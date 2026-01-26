#!/bin/bash
# Singularity-based Kafka Stack Launcher
# Equivalent to docker-compose.yml

set -e

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
INSTANCE_DIR="${SCRIPT_DIR}/instances"
DATA_DIR="${SCRIPT_DIR}/data"
LOG_DIR="${SCRIPT_DIR}/logs"
CONNECTORS_DIR="${SCRIPT_DIR}/../connectors"

# Create necessary directories
mkdir -p "${INSTANCE_DIR}" "${DATA_DIR}" "${LOG_DIR}" "${CONNECTORS_DIR}"
mkdir -p "${DATA_DIR}/zookeeper/data" "${DATA_DIR}/zookeeper/log"
mkdir -p "${DATA_DIR}/kafka/data"
mkdir -p "${DATA_DIR}/schema-registry"

# Colors for output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
NC='\033[0m' # No Color

log_info() { echo -e "${GREEN}[INFO]${NC} $1"; }
log_warn() { echo -e "${YELLOW}[WARN]${NC} $1"; }
log_error() { echo -e "${RED}[ERROR]${NC} $1"; }

# Function to wait for a service to be ready
wait_for_port() {
    local host=$1
    local port=$2
    local service=$3
    local max_attempts=${4:-60}
    local attempt=1

    log_info "Waiting for ${service} on ${host}:${port}..."
    while ! nc -z "${host}" "${port}" 2>/dev/null; do
        if [ $attempt -ge $max_attempts ]; then
            log_error "${service} failed to start after ${max_attempts} attempts"
            return 1
        fi
        sleep 2
        ((attempt++))
    done
    log_info "${service} is ready!"
}

# Pull/build Singularity images from Docker Hub
pull_images() {
    log_info "Pulling Singularity images from Docker Hub..."

    cd "${INSTANCE_DIR}"

    if [ ! -f "zookeeper.sif" ]; then
        log_info "Pulling Zookeeper image..."
        singularity pull docker://confluentinc/cp-zookeeper:latest
        mv cp-zookeeper_latest.sif zookeeper.sif
    fi

    if [ ! -f "kafka.sif" ]; then
        log_info "Pulling Kafka broker image..."
        singularity pull docker://confluentinc/cp-kafka:latest
        mv cp-kafka_latest.sif kafka.sif
    fi

    if [ ! -f "schema-registry.sif" ]; then
        log_info "Pulling Schema Registry image..."
        singularity pull docker://confluentinc/cp-schema-registry:latest
        mv cp-schema-registry_latest.sif schema-registry.sif
    fi

    if [ ! -f "kafka-connect.sif" ]; then
        log_info "Pulling Kafka Connect image..."
        singularity pull docker://confluentinc/cp-kafka-connect-base:latest
        mv cp-kafka-connect-base_latest.sif kafka-connect.sif
    fi

    if [ ! -f "ksqldb.sif" ]; then
        log_info "Pulling ksqlDB image..."
        singularity pull docker://confluentinc/cp-ksqldb-server:7.6.0
        mv cp-ksqldb-server_7.6.0.sif ksqldb.sif
    fi

    log_info "All images pulled successfully!"
}

# Start Zookeeper
start_zookeeper() {
    log_info "Starting Zookeeper..."

    singularity instance start \
        --writable-tmpfs \
        --bind "${DATA_DIR}/zookeeper/data:/var/lib/zookeeper/data" \
        --bind "${DATA_DIR}/zookeeper/log:/var/lib/zookeeper/log" \
        --env ZOOKEEPER_CLIENT_PORT=2181 \
        --env ZOOKEEPER_TICK_TIME=2000 \
        "${INSTANCE_DIR}/zookeeper.sif" \
        zookeeper

    # Run the zookeeper process inside the instance
    singularity exec instance://zookeeper \
        /etc/confluent/docker/run > "${LOG_DIR}/zookeeper.log" 2>&1 &

    wait_for_port localhost 2181 "Zookeeper"
}

# Start Kafka Broker
start_broker() {
    log_info "Starting Kafka Broker..."

    # Note: In Singularity with host networking, services communicate via localhost
    # We need to adjust the advertised listeners accordingly

    singularity instance start \
        --writable-tmpfs \
        --bind "${DATA_DIR}/kafka/data:/var/lib/kafka/data" \
        --env KAFKA_BROKER_ID=1 \
        --env KAFKA_ZOOKEEPER_CONNECT=localhost:2181 \
        --env KAFKA_LISTENER_SECURITY_PROTOCOL_MAP="PLAINTEXT:PLAINTEXT,PLAINTEXT_HOST:PLAINTEXT,HERCULES:PLAINTEXT,NGARRU:PLAINTEXT,EDGAR:PLAINTEXT,FUTURE:PLAINTEXT,FUTURE1:PLAINTEXT,FUTURE2:PLAINTEXT,FUTURE3:PLAINTEXT" \
        --env KAFKA_INTER_BROKER_LISTENER_NAME=PLAINTEXT \
        --env KAFKA_LISTENERS="PLAINTEXT://:29092,PLAINTEXT_HOST://:9092,HERCULES://:39092,NGARRU://:49092,EDGAR://:59092,FUTURE://:60092,FUTURE1://:60093,FUTURE2://:60094,FUTURE3://:60095" \
        --env KAFKA_ADVERTISED_LISTENERS="PLAINTEXT://localhost:29092,PLAINTEXT_HOST://localhost:9092,HERCULES://localhost:39092,NGARRU://localhost:49092,EDGAR://localhost:59092,FUTURE://localhost:60092,FUTURE1://localhost:60093,FUTURE2://localhost:60094,FUTURE3://localhost:60095" \
        --env KAFKA_AUTO_CREATE_TOPICS_ENABLE=true \
        --env KAFKA_DELETE_TOPIC_ENABLE=true \
        --env KAFKA_OFFSETS_TOPIC_REPLICATION_FACTOR=1 \
        --env KAFKA_TRANSACTION_STATE_LOG_MIN_ISR=1 \
        --env KAFKA_TRANSACTION_STATE_LOG_REPLICATION_FACTOR=1 \
        --env KAFKA_GROUP_INITIAL_REBALANCE_DELAY_MS=100 \
        "${INSTANCE_DIR}/kafka.sif" \
        broker

    singularity exec instance://broker \
        /etc/confluent/docker/run > "${LOG_DIR}/broker.log" 2>&1 &

    wait_for_port localhost 9092 "Kafka Broker"
}

# Start Schema Registry
start_schema_registry() {
    log_info "Starting Schema Registry..."

    singularity instance start \
        --writable-tmpfs \
        --bind "${DATA_DIR}/schema-registry:/var/lib/schema-registry" \
        --env SCHEMA_REGISTRY_HOST_NAME=localhost \
        --env SCHEMA_REGISTRY_KAFKASTORE_BOOTSTRAP_SERVERS=localhost:29092 \
        --env SCHEMA_REGISTRY_LISTENERS=http://0.0.0.0:8081 \
        --env SCHEMA_REGISTRY_DEBUG=true \
        "${INSTANCE_DIR}/schema-registry.sif" \
        schema-registry

    singularity exec instance://schema-registry \
        /etc/confluent/docker/run > "${LOG_DIR}/schema-registry.log" 2>&1 &

    wait_for_port localhost 8081 "Schema Registry"
}

# Start Kafka Connect
start_kafka_connect() {
    log_info "Starting Kafka Connect..."

    singularity instance start \
        --writable-tmpfs \
        --bind "${CONNECTORS_DIR}:/connectors" \
        --env CONNECT_BOOTSTRAP_SERVERS=localhost:29092 \
        --env CONNECT_REST_ADVERTISED_HOST_NAME=localhost \
        --env CONNECT_REST_PORT=8083 \
        --env CONNECT_GROUP_ID=kafka-connect \
        --env CONNECT_CONFIG_STORAGE_TOPIC=_kafka-connect-configs \
        --env CONNECT_OFFSET_STORAGE_TOPIC=_kafka-connect-offsets \
        --env CONNECT_STATUS_STORAGE_TOPIC=_kafka-connect-status \
        --env CONNECT_KEY_CONVERTER=io.confluent.connect.avro.AvroConverter \
        --env CONNECT_KEY_CONVERTER_SCHEMA_REGISTRY_URL=http://localhost:8081 \
        --env CONNECT_VALUE_CONVERTER=io.confluent.connect.avro.AvroConverter \
        --env CONNECT_VALUE_CONVERTER_SCHEMA_REGISTRY_URL=http://localhost:8081 \
        --env CONNECT_LOG4J_ROOT_LOGLEVEL=INFO \
        --env CONNECT_LOG4J_LOGGERS="org.apache.kafka.connect.runtime.rest=WARN,org.reflections=ERROR" \
        --env CONNECT_CONFIG_STORAGE_REPLICATION_FACTOR=1 \
        --env CONNECT_OFFSET_STORAGE_REPLICATION_FACTOR=1 \
        --env CONNECT_STATUS_STORAGE_REPLICATION_FACTOR=1 \
        --env CONNECT_PLUGIN_PATH="/usr/share/java,/usr/share/confluent-hub-components/,/connectors/" \
        "${INSTANCE_DIR}/kafka-connect.sif" \
        kafka-connect

    # Install connectors and start Kafka Connect
    singularity exec instance://kafka-connect bash -c '
        echo "Installing connector plugins..."
        confluent-hub install --no-prompt debezium/debezium-connector-mysql:2.4.2
        confluent-hub install --no-prompt mdrogalis/voluble:0.3.1
        confluent-hub install --no-prompt confluentinc/kafka-connect-jdbc:10.8.4

        echo "Copying JDBC driver for MariaDB..."
        cd /usr/share/confluent-hub-components/confluentinc-kafka-connect-jdbc/lib/
        wget -q https://dlm.mariadb.com/3752064/Connectors/java/connector-java-2.7.12/mariadb-java-client-2.7.12.jar

        echo "Launching Kafka Connect worker..."
        /etc/confluent/docker/run
    ' > "${LOG_DIR}/kafka-connect.log" 2>&1 &

    wait_for_port localhost 8083 "Kafka Connect" 120
}

# Start ksqlDB
start_ksqldb() {
    log_info "Starting ksqlDB..."

    singularity instance start \
        --writable-tmpfs \
        --env KSQL_LISTENERS=http://0.0.0.0:8088 \
        --env KSQL_BOOTSTRAP_SERVERS=localhost:29092 \
        --env KSQL_KSQL_LOGGING_PROCESSING_STREAM_AUTO_CREATE=true \
        --env KSQL_KSQL_LOGGING_PROCESSING_TOPIC_AUTO_CREATE=true \
        --env KSQL_KSQL_CONNECT_URL=http://localhost:8083 \
        --env KSQL_KSQL_SCHEMA_REGISTRY_URL=http://localhost:8081 \
        --env KSQL_KSQL_SERVICE_ID=confluent_rmoff_01 \
        --env "KSQL_KSQL_HIDDEN_TOPICS=^_.*" \
        "${INSTANCE_DIR}/ksqldb.sif" \
        ksqldb

    singularity exec instance://ksqldb \
        /etc/confluent/docker/run > "${LOG_DIR}/ksqldb.log" 2>&1 &

    wait_for_port localhost 8088 "ksqlDB"
}

# Stop all instances
stop_all() {
    log_info "Stopping all Singularity instances..."

    for instance in ksqldb kafka-connect schema-registry broker zookeeper; do
        if singularity instance list | grep -q "${instance}"; then
            log_info "Stopping ${instance}..."
            singularity instance stop "${instance}" 2>/dev/null || true
        fi
    done

    log_info "All instances stopped."
}

# Show status of all instances
status() {
    log_info "Singularity instances status:"
    singularity instance list

    echo ""
    log_info "Port status:"
    for port in 2181 9092 29092 8081 8083 8088; do
        if nc -z localhost "${port}" 2>/dev/null; then
            echo -e "  Port ${port}: ${GREEN}OPEN${NC}"
        else
            echo -e "  Port ${port}: ${RED}CLOSED${NC}"
        fi
    done
}

# Show logs
show_logs() {
    local service=$1
    if [ -z "${service}" ]; then
        log_error "Please specify a service: zookeeper, broker, schema-registry, kafka-connect, ksqldb"
        return 1
    fi

    local log_file="${LOG_DIR}/${service}.log"
    if [ -f "${log_file}" ]; then
        tail -f "${log_file}"
    else
        log_error "Log file not found: ${log_file}"
    fi
}

# Main execution
case "${1:-}" in
    pull)
        pull_images
        ;;
    start)
        pull_images
        start_zookeeper
        start_broker
        start_schema_registry
        start_kafka_connect
        start_ksqldb
        log_info "All services started successfully!"
        status
        ;;
    stop)
        stop_all
        ;;
    restart)
        stop_all
        sleep 5
        $0 start
        ;;
    status)
        status
        ;;
    logs)
        show_logs "$2"
        ;;
    *)
        echo "Usage: $0 {pull|start|stop|restart|status|logs <service>}"
        echo ""
        echo "Commands:"
        echo "  pull     - Pull Singularity images from Docker Hub"
        echo "  start    - Start all services (pulls images if needed)"
        echo "  stop     - Stop all services"
        echo "  restart  - Stop and start all services"
        echo "  status   - Show status of all services"
        echo "  logs     - Show logs for a service (zookeeper|broker|schema-registry|kafka-connect|ksqldb)"
        exit 1
        ;;
esac
