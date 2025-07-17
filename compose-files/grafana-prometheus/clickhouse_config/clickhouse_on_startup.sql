SET profile = 'admin';

CREATE DATABASE IF NOT EXISTS metrics;

CREATE TABLE IF NOT EXISTS prometheus_metrics ENGINE=TimeSeries;

CREATE ROLE IF NOT EXISTS prometheus_rw;
CREATE ROLE IF NOT EXISTS grafana_ro;

GRANT SELECT, INSERT ON metrics.prometheus_metrics TO prometheus_rw;
GRANT SELECT ON metrics.prometheus_metrics TO grafana_ro;

GRANT prometheus_rw TO prometheus;
GRANT grafana_ro TO grafana;

SET DEFAULT ROLE prometheus_rw TO prometheus;
SET DEFAULT ROLE grafana_ro TO grafana;
