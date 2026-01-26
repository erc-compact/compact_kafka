#!/bin/bash
# Run individual Kafka stack services with Singularity
# Use this for systems where 'singularity instance' is not available or preferred
# Each service runs in the foreground - use screen/tmux or separate terminals

set -e

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
INSTANCE_DIR="${SCRIPT_DIR}/instances"
DATA_DIR="${SCRIPT_DIR}/data"
CONNECTORS_DIR="${SCRIPT_DIR}/../connectors"

mkdir -p "${INSTANCE_DIR}" "${DATA_DIR}" "${CONNECTORS_DIR}"
mkdir -p "${DATA_DIR}/zookeeper" "${DATA_DIR}/kafka" "${DATA_DIR}/schema-registry"

SERVICE=$1

case "${SERVICE}" in
    zookeeper)
        singularity exec \
            --bind "${DATA_DIR}/zookeeper:/var/lib/zookeeper" \
            --env ZOOKEEPER_CLIENT_PORT=2181 \
            --env ZOOKEEPER_TICK_TIME=2000 \
            "${INSTANCE_DIR}/zookeeper.sif" \
            /etc/confluent/docker/run
        ;;

    broker)
        singularity exec \
            --bind "${DATA_DIR}/kafka:/var/lib/kafka" \
            --env KAFKA_BROKER_ID=1 \
            --env KAFKA_ZOOKEEPER_CONNECT=localhost:2181 \
            --env KAFKA_LISTENER_SECURITY_PROTOCOL_MAP="PLAINTEXT:PLAINTEXT,PLAINTEXT_HOST:PLAINTEXT,HERCULES:PLAINTEXT,NGARRU:PLAINTEXT,EDGAR:PLAINTEXT,FUTURE:PLAINTEXT,FUTURE1:PLAINTEXT,FUTURE2:PLAINTEXT,FUTURE3:PLAINTEXT" \
            --env KAFKA_INTER_BROKER_LISTENER_NAME=PLAINTEXT \
            --env KAFKA_LISTENERS="PLAINTEXT://:29092,PLAINTEXT_HOST://:9092,HERCULES://:9093 \
            --env KAFKA_ADVERTISED_LISTENERS="PLAINTEXT://localhost:29092,PLAINTEXT_HOST://localhost:9092 \
            --env KAFKA_AUTO_CREATE_TOPICS_ENABLE=true \
            --env KAFKA_DELETE_TOPIC_ENABLE=true \
            --env KAFKA_OFFSETS_TOPIC_REPLICATION_FACTOR=1 \
            --env KAFKA_TRANSACTION_STATE_LOG_MIN_ISR=1 \
            --env KAFKA_TRANSACTION_STATE_LOG_REPLICATION_FACTOR=1 \
            --env KAFKA_GROUP_INITIAL_REBALANCE_DELAY_MS=100 \
            "${INSTANCE_DIR}/kafka.sif" \
            /etc/confluent/docker/run
        ;;

    schema-registry)
        singularity exec \
            --bind "${DATA_DIR}/schema-registry:/var/lib/schema-registry" \
            --env SCHEMA_REGISTRY_HOST_NAME=localhost \
            --env SCHEMA_REGISTRY_KAFKASTORE_BOOTSTRAP_SERVERS=localhost:29092 \
            --env SCHEMA_REGISTRY_LISTENERS=http://0.0.0.0:8081 \
            --env SCHEMA_REGISTRY_DEBUG=true \
            "${INSTANCE_DIR}/schema-registry.sif" \
            /etc/confluent/docker/run
        ;;

    kafka-connect)
        singularity exec \
            --bind "${CONNECTORS_DIR}:/connectors" \
            --writable-tmpfs \
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
            bash -c '
                confluent-hub install --no-prompt debezium/debezium-connector-mysql:2.4.2
                confluent-hub install --no-prompt mdrogalis/voluble:0.3.1
                confluent-hub install --no-prompt confluentinc/kafka-connect-jdbc:10.8.4
                cd /usr/share/confluent-hub-components/confluentinc-kafka-connect-jdbc/lib/
                wget -q https://dlm.mariadb.com/3752064/Connectors/java/connector-java-2.7.12/mariadb-java-client-2.7.12.jar || true
                /etc/confluent/docker/run
            '
        ;;

    ksqldb)
        singularity exec \
            --env KSQL_LISTENERS=http://0.0.0.0:8088 \
            --env KSQL_BOOTSTRAP_SERVERS=localhost:29092 \
            --env KSQL_KSQL_LOGGING_PROCESSING_STREAM_AUTO_CREATE=true \
            --env KSQL_KSQL_LOGGING_PROCESSING_TOPIC_AUTO_CREATE=true \
            --env KSQL_KSQL_CONNECT_URL=http://localhost:8083 \
            --env KSQL_KSQL_SCHEMA_REGISTRY_URL=http://localhost:8081 \
            --env KSQL_KSQL_SERVICE_ID=confluent_rmoff_01 \
            --env "KSQL_KSQL_HIDDEN_TOPICS=^_.*" \
            "${INSTANCE_DIR}/ksqldb.sif" \
            /etc/confluent/docker/run
        ;;

    *)
        echo "Usage: $0 {zookeeper|broker|schema-registry|kafka-connect|ksqldb}"
        echo ""
        echo "Run each service in a separate terminal/screen session:"
        echo "  Terminal 1: $0 zookeeper"
        echo "  Terminal 2: $0 broker         # wait for zookeeper"
        echo "  Terminal 3: $0 schema-registry # wait for broker"
        echo "  Terminal 4: $0 kafka-connect   # wait for schema-registry"
        echo "  Terminal 5: $0 ksqldb          # wait for kafka-connect"
        exit 1
        ;;
esac
