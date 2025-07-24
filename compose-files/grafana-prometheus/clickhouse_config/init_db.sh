#!/bin/bash
set -e

CLICKHOUSE_HOST="localhost"
CLICKHOUSE_PORT="9000"
ADMIN_PASSWORD_PLAIN_TEXT="${ADMIN_PASSWORD_PLAIN_TEXT}"

echo "Wait 3 seconds for the db to boot up"
sleep 3
echo "Executing the queries....."

clickhouse-client \
    --host="$CLICKHOUSE_HOST" \
    --port="$CLICKHOUSE_PORT" \
    --user="admin" \
    --password="$ADMIN_PASSWORD_PLAIN_TEXT" \
    --multiquery << EOF


CREATE DATABASE IF NOT EXISTS metrics;

SET allow_experimental_time_series_table = 1;

USE metrics;

CREATE TABLE IF NOT EXISTS prometheus_metrics ENGINE=TimeSeries;

CREATE USER IF NOT EXISTS grafana_readonly
IDENTIFIED WITH sha256_hash BY '${GRAFANA_PASSWORD_SHA256_HASH}'
HOST IP '172.88.1.252/24';

CREATE USER IF NOT EXISTS prometheus_remote_write
IDENTIFIED WITH sha256_hash BY '${PROMETHEUS_PASSWORD_SHA256_HASH}'
HOST IP '172.88.1.252/24';


CREATE ROLE IF NOT EXISTS prometheus_rw;
CREATE ROLE IF NOT EXISTS grafana_ro;

GRANT SELECT, INSERT ON metrics.prometheus_metrics TO prometheus_rw;
GRANT SELECT ON metrics.prometheus_metrics TO grafana_ro;

GRANT prometheus_rw TO prometheus_remote_write;
GRANT grafana_ro TO grafana_readonly;

ALTER USER prometheus_remote_write DEFAULT ROLE prometheus_rw;
ALTER USER grafana_readonly DEFAULT ROLE grafana_ro;
EOF