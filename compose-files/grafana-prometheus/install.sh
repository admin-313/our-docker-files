#!/bin/bash

set -euo pipefail
echo "This script will install docker compose deployment of Grafana stack"

# Repo base (raw) URL
BASE_URL="https://raw.githubusercontent.com/admin-313/our-docker-files/main/compose-files/grafana-prometheus"

need() { command -v "$1" >/dev/null 2>&1 || { echo "Missing dependency: $1" >&2; exit 1; }; }
need curl

# List of files to fetch (paths are relative to the repo root above)
FILES=(
  "example.env"
  "docker-compose.yml"
  "grafana.ini"
  "blackbox.yml"
  "sd_configs/example.blackbox_targets.json"
  "prometheus_config/entrypoint.sh"
  "prometheus_config/example.prometheus.yml"
  "clickhouse_config/init_db.sh"
  "clickhouse_config/config.d/config.xml"
  "clickhouse_config/users.d/users.xml"
)

for relpath in "${FILES[@]}"; do
  dest="$relpath"
  mkdir -p "$(dirname "$dest")"

  url="$BASE_URL/$relpath"
  echo "Downloading: $url"
  curl -fsSL "$url" -o "$dest"

  # make scripts executable
  case "$dest" in
    *.sh) chmod +x "$dest" ;;
  esac
done

mv example.env .env
mv sd_configs/example.blackbox_targets.json sd_configs/blackbox_targets.json
mv prometheus_config/example.prometheus.yml prometheus_config/prometheus.yml

echo "All files downloaded."

echo "Now populate the following files with your configs:"
echo "sd_configs/blackbox_targets.json"
echo "prometheus_config/prometheus.yml"
echo ".env"