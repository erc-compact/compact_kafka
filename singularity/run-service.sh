#!/bin/bash
# Run individual Kafka stack services with Singularity
# Each service runs in the foreground - use screen/tmux or separate terminals

set -e

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
INSTANCE_DIR="${SCRIPT_DIR}/instances"
DATA_DIR="${SCRIPT_DIR}/data"
CONNECTORS_DIR="${SCRIPT_DIR}/../connectors"

mkdir -p "${INSTANCE_DIR}" "${DATA_DIR}" "${CONNECTORS_DIR}"
mkdir -p "${DATA_DIR}/zookeeper/data" "${DATA_DIR}/zookeeper/log"
mkdir -p "${DATA_DIR}/kafka/data"
mkdir -p "${DATA_DIR}/schema-registry"
mkdir -p "${DATA_DIR}/ksqldb/etc"

SERVICE=$1

case "${SERVICE}" in
    zookeeper)
        export APPTAINERENV_ZOOKEEPER_CLIENT_PORT=2181
        export APPTAINERENV_ZOOKEEPER_TICK_TIME=2000

        singularity exec \
            --writable-tmpfs \
            --bind "${DATA_DIR}/zookeeper/data:/var/lib/zookeeper/data" \
            --bind "${DATA_DIR}/zookeeper/log:/var/lib/zookeeper/log" \
            "${INSTANCE_DIR}/zookeeper.sif" \
            /etc/confluent/docker/run
        ;;

    broker)
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
            /etc/confluent/docker/run
        ;;

    schema-registry)
        export APPTAINERENV_SCHEMA_REGISTRY_HOST_NAME=localhost
        export APPTAINERENV_SCHEMA_REGISTRY_KAFKASTORE_BOOTSTRAP_SERVERS="PLAINTEXT://localhost:29092"
        export APPTAINERENV_SCHEMA_REGISTRY_LISTENERS=http://0.0.0.0:8081
        export APPTAINERENV_SCHEMA_REGISTRY_DEBUG=true

        singularity exec \
            --writable-tmpfs \
            --bind "${DATA_DIR}/schema-registry:/var/lib/schema-registry" \
            "${INSTANCE_DIR}/schema-registry.sif" \
            /etc/confluent/docker/run
        ;;

    kafka-connect)
        export APPTAINERENV_CONNECT_BOOTSTRAP_SERVERS="PLAINTEXT://localhost:29092"
        export APPTAINERENV_CONNECT_REST_ADVERTISED_HOST_NAME=localhost
        export APPTAINERENV_CONNECT_REST_PORT=8083
        export APPTAINERENV_CONNECT_GROUP_ID="kafka-connect"
        export APPTAINERENV_CONNECT_CONFIG_STORAGE_TOPIC="_kafka-connect-configs"
        export APPTAINERENV_CONNECT_OFFSET_STORAGE_TOPIC="_kafka-connect-offsets"
        export APPTAINERENV_CONNECT_STATUS_STORAGE_TOPIC="_kafka-connect-status"
        export APPTAINERENV_CONNECT_KEY_CONVERTER="io.confluent.connect.avro.AvroConverter"
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
                confluent-hub install --no-prompt debezium/debezium-connector-mysql:2.4.2
                confluent-hub install --no-prompt confluentinc/kafka-connect-jdbc:10.8.4
                cd /usr/share/confluent-hub-components/confluentinc-kafka-connect-jdbc/lib/
                curl -fsSL -o mariadb-java-client-2.7.12.jar "https://dlm.mariadb.com/3752064/Connectors/java/connector-java-2.7.12/mariadb-java-client-2.7.12.jar" || true
                /etc/confluent/docker/run
            '
        ;;

    ksqldb)
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
