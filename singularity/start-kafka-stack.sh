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
mkdir -p "${DATA_DIR}/ksqldb/etc"


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
        singularity pull docker://confluentinc/cp-zookeeper:7.5.3
        mv cp-zookeeper_7.5.3.sif zookeeper.sif
    fi

    if [ ! -f "kafka.sif" ]; then
        log_info "Pulling Kafka broker image..."
        singularity pull docker://confluentinc/cp-kafka:7.5.3
        mv cp-kafka_7.5.3.sif kafka.sif
    fi

    if [ ! -f "schema-registry.sif" ]; then
        log_info "Pulling Schema Registry image..."
        singularity pull docker://confluentinc/cp-schema-registry:7.5.3
        mv cp-schema-registry_7.5.3.sif schema-registry.sif
    fi

    if [ ! -f "kafka-connect.sif" ]; then
        log_info "Pulling Kafka Connect image..."
        singularity pull docker://confluentinc/cp-kafka-connect-base:7.5.3
        mv cp-kafka-connect-base_7.5.3.sif kafka-connect.sif
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

    export APPTAINERENV_ZOOKEEPER_CLIENT_PORT=2181
    export APPTAINERENV_ZOOKEEPER_TICK_TIME=2000

    singularity exec \
        --writable-tmpfs \
        --bind "${DATA_DIR}/zookeeper/data:/var/lib/zookeeper/data" \
        --bind "${DATA_DIR}/zookeeper/log:/var/lib/zookeeper/log" \
        "${INSTANCE_DIR}/zookeeper.sif" \
        /etc/confluent/docker/run > "${LOG_DIR}/zookeeper.log" 2>&1 &

    ZOOKEEPER_PID=$!
    echo $ZOOKEEPER_PID > "${LOG_DIR}/zookeeper.pid"

    wait_for_port localhost 2181 "Zookeeper"
}

# Start Kafka Broker
start_broker() {
    log_info "Starting Kafka Broker..."

    # Note: In Singularity with host networking, services communicate via localhost
    export APPTAINERENV_KAFKA_BROKER_ID=1
    export APPTAINERENV_KAFKA_ZOOKEEPER_CONNECT=localhost:2181
    export APPTAINERENV_KAFKA_LISTENER_SECURITY_PROTOCOL_MAP="PLAINTEXT:PLAINTEXT,PLAINTEXT_HOST:PLAINTEXT,HERCULES:PLAINTEXT,NGARRU:PLAINTEXT,EDGAR:PLAINTEXT,FUTURE:PLAINTEXT,FUTURE1:PLAINTEXT,FUTURE2:PLAINTEXT,FUTURE3:PLAINTEXT"
    export APPTAINERENV_KAFKA_INTER_BROKER_LISTENER_NAME=PLAINTEXT
    export APPTAINERENV_KAFKA_LISTENERS="PLAINTEXT://:29092,PLAINTEXT_HOST://:9092,HERCULES://:39092,NGARRU://:49092,EDGAR://:59092,FUTURE://:60092,FUTURE1://:60093,FUTURE2://:60094,FUTURE3://:60095"
    export APPTAINERENV_KAFKA_ADVERTISED_LISTENERS="PLAINTEXT://localhost:29092,PLAINTEXT_HOST://localhost:9092,HERCULES://localhost:39092,NGARRU://localhost:49092,EDGAR://localhost:59092,FUTURE://localhost:60092,FUTURE1://localhost:60093,FUTURE2://localhost:60094,FUTURE3://localhost:60095"
    export APPTAINERENV_KAFKA_AUTO_CREATE_TOPICS_ENABLE=true
    export APPTAINERENV_KAFKA_DELETE_TOPIC_ENABLE=true
    export APPTAINERENV_KAFKA_OFFSETS_TOPIC_REPLICATION_FACTOR=1
    export APPTAINERENV_KAFKA_TRANSACTION_STATE_LOG_MIN_ISR=1
    export APPTAINERENV_KAFKA_TRANSACTION_STATE_LOG_REPLICATION_FACTOR=1
    export APPTAINERENV_KAFKA_GROUP_INITIAL_REBALANCE_DELAY_MS=100

    singularity exec \
        --writable-tmpfs \
        --bind "${DATA_DIR}/kafka/data:/var/lib/kafka/data" \
        "${INSTANCE_DIR}/kafka.sif" \
        /etc/confluent/docker/run > "${LOG_DIR}/broker.log" 2>&1 &

    BROKER_PID=$!
    echo $BROKER_PID > "${LOG_DIR}/broker.pid"

    wait_for_port localhost 9092 "Kafka Broker"
}

# Start Schema Registry
start_schema_registry() {
    log_info "Starting Schema Registry..."

    export APPTAINERENV_SCHEMA_REGISTRY_HOST_NAME=localhost
    export APPTAINERENV_SCHEMA_REGISTRY_KAFKASTORE_BOOTSTRAP_SERVERS=localhost:29092
    export APPTAINERENV_SCHEMA_REGISTRY_LISTENERS=http://0.0.0.0:8081
    export APPTAINERENV_SCHEMA_REGISTRY_DEBUG=true

    singularity exec \
        --writable-tmpfs \
        --bind "${DATA_DIR}/schema-registry:/var/lib/schema-registry" \
        "${INSTANCE_DIR}/schema-registry.sif" \
        /etc/confluent/docker/run > "${LOG_DIR}/schema-registry.log" 2>&1 &

    SCHEMA_REGISTRY_PID=$!
    echo $SCHEMA_REGISTRY_PID > "${LOG_DIR}/schema-registry.pid"

    wait_for_port localhost 8081 "Schema Registry"
}

# Start Kafka Connect
start_kafka_connect() {
    log_info "Starting Kafka Connect..."

    export APPTAINERENV_CONNECT_BOOTSTRAP_SERVERS=localhost:29092
    export APPTAINERENV_CONNECT_REST_ADVERTISED_HOST_NAME=localhost
    export APPTAINERENV_CONNECT_REST_PORT=8083
    export APPTAINERENV_CONNECT_GROUP_ID=kafka-connect
    export APPTAINERENV_CONNECT_CONFIG_STORAGE_TOPIC=_kafka-connect-configs
    export APPTAINERENV_CONNECT_OFFSET_STORAGE_TOPIC=_kafka-connect-offsets
    export APPTAINERENV_CONNECT_STATUS_STORAGE_TOPIC=_kafka-connect-status
    export APPTAINERENV_CONNECT_KEY_CONVERTER=io.confluent.connect.avro.AvroConverter
    export APPTAINERENV_CONNECT_KEY_CONVERTER_SCHEMA_REGISTRY_URL=http://localhost:8081
    export APPTAINERENV_CONNECT_VALUE_CONVERTER=io.confluent.connect.avro.AvroConverter
    export APPTAINERENV_CONNECT_VALUE_CONVERTER_SCHEMA_REGISTRY_URL=http://localhost:8081
    export APPTAINERENV_CONNECT_LOG4J_ROOT_LOGLEVEL=INFO
    export APPTAINERENV_CONNECT_LOG4J_LOGGERS="org.apache.kafka.connect.runtime.rest=WARN,org.reflections=ERROR"
    export APPTAINERENV_CONNECT_CONFIG_STORAGE_REPLICATION_FACTOR=1
    export APPTAINERENV_CONNECT_OFFSET_STORAGE_REPLICATION_FACTOR=1
    export APPTAINERENV_CONNECT_STATUS_STORAGE_REPLICATION_FACTOR=1
    export APPTAINERENV_CONNECT_PLUGIN_PATH="/usr/share/java,/usr/share/confluent-hub-components/,/connectors/"

    singularity exec \
        --writable-tmpfs \
        --bind "${CONNECTORS_DIR}:/connectors" \
        "${INSTANCE_DIR}/kafka-connect.sif" \
        bash -c '
            echo "Installing connector plugins..."
            confluent-hub install --no-prompt debezium/debezium-connector-mysql:2.4.2
            confluent-hub install --no-prompt mdrogalis/voluble:0.3.1
            confluent-hub install --no-prompt confluentinc/kafka-connect-jdbc:10.8.4

            echo "Copying JDBC driver for MariaDB..."
            cd /usr/share/confluent-hub-components/confluentinc-kafka-connect-jdbc/lib/
            curl -fsSL -o mariadb-java-client-2.7.12.jar "https://dlm.mariadb.com/3752064/Connectors/java/connector-java-2.7.12/mariadb-java-client-2.7.12.jar" || true

            echo "Launching Kafka Connect worker..."
            /etc/confluent/docker/run
        ' > "${LOG_DIR}/kafka-connect.log" 2>&1 &

    KAFKA_CONNECT_PID=$!
    echo $KAFKA_CONNECT_PID > "${LOG_DIR}/kafka-connect.pid"

    wait_for_port localhost 8083 "Kafka Connect" 120
}

# Start ksqlDB
start_ksqldb() {
    log_info "Starting ksqlDB..."

    export APPTAINERENV_KSQL_LISTENERS=http://0.0.0.0:8088
    export APPTAINERENV_KSQL_BOOTSTRAP_SERVERS=localhost:29092
    export APPTAINERENV_KSQL_KSQL_LOGGING_PROCESSING_STREAM_AUTO_CREATE=true
    export APPTAINERENV_KSQL_KSQL_LOGGING_PROCESSING_TOPIC_AUTO_CREATE=true
    export APPTAINERENV_KSQL_KSQL_CONNECT_URL=http://localhost:8083
    export APPTAINERENV_KSQL_KSQL_SCHEMA_REGISTRY_URL=http://localhost:8081
    export APPTAINERENV_KSQL_KSQL_SERVICE_ID=confluent_rmoff_01
    export "APPTAINERENV_KSQL_KSQL_HIDDEN_TOPICS=^_.*"

    singularity exec \
        --writable-tmpfs \
        --bind "${DATA_DIR}/ksqldb/etc:/etc/ksqldb-server" \
        "${INSTANCE_DIR}/ksqldb.sif" \
        /etc/confluent/docker/run > "${LOG_DIR}/ksqldb.log" 2>&1 &

    KSQLDB_PID=$!
    echo $KSQLDB_PID > "${LOG_DIR}/ksqldb.pid"

    wait_for_port localhost 8088 "ksqlDB"
}

# Stop all services
stop_all() {
    log_info "Stopping all Singularity services..."

    for service in ksqldb kafka-connect schema-registry broker zookeeper; do
        local pid_file="${LOG_DIR}/${service}.pid"
        if [ -f "${pid_file}" ]; then
            local pid=$(cat "${pid_file}")
            if kill -0 "${pid}" 2>/dev/null; then
                log_info "Stopping ${service} (PID: ${pid})..."
                kill "${pid}" 2>/dev/null || true
                sleep 2
                # Force kill if still running
                kill -9 "${pid}" 2>/dev/null || true
            fi
            rm -f "${pid_file}"
        fi
    done

    log_info "All services stopped."
}

# Show status of all services
status() {
    log_info "Service status:"
    for service in zookeeper broker schema-registry kafka-connect ksqldb; do
        local pid_file="${LOG_DIR}/${service}.pid"
        if [ -f "${pid_file}" ]; then
            local pid=$(cat "${pid_file}")
            if kill -0 "${pid}" 2>/dev/null; then
                echo -e "  ${service}: ${GREEN}RUNNING${NC} (PID: ${pid})"
            else
                echo -e "  ${service}: ${RED}STOPPED${NC} (stale PID file)"
            fi
        else
            echo -e "  ${service}: ${RED}STOPPED${NC}"
        fi
    done

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
