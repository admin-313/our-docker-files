CREATE USER IF NOT EXISTS 'database_admin'
IDENTIFIED WITH sha256_password BY '6c2ef1a8064856556b9a04c392d064b59b82f2913d2f4561e69618c2cd939e72';

GRANT default_role TO database_admin;

CREATE DATABASE IF NOT EXISTS metrics;

SET allow_experimental_time_series_table = 1;

USE metrics;

CREATE TABLE IF NOT EXISTS prometheus_metrics ENGINE=TimeSeries;

CREATE ROLE IF NOT EXISTS prometheus_rw;
CREATE ROLE IF NOT EXISTS grafana_ro;

GRANT SELECT, INSERT ON metrics.prometheus_metrics TO prometheus_rw;
GRANT SELECT ON metrics.prometheus_metrics TO grafana_ro;

GRANT prometheus_rw TO prometheus;
GRANT grafana_ro TO grafana;

ALTER USER prometheus DEFAULT ROLE prometheus_rw;
ALTER USER grafana DEFAULT ROLE grafana_ro;