#!/bin/sh

# Substitute environment variables in the template
sed -e "s/\${PROMETHEUS_CLICKHOUSE_USERNAME}/${PROMETHEUS_CLICKHOUSE_USERNAME}/g" \
    -e "s/\${PROMETHEUS_CLICKHOUSE_PASSWORD}/${PROMETHEUS_CLICKHOUSE_PASSWORD}/g" \
    /etc/prometheus/prometheus.yml.template > /etc/prometheus/prometheus.yml

# Verify the substitution worked
echo "Generated prometheus.yml"
echo "Booting up prometheus....\n\n\n"

# Start Prometheus with the generated config
exec /bin/prometheus \
  --config.file=/etc/prometheus/prometheus.yml \
  --web.enable-lifecycle \
  "$@"