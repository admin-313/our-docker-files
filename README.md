# our-docker-files
[![Build Status](https://github.com/admin-313/our-docker-files/actions/workflows/docker-compose-build.yml/badge.svg)](https://github.com/admin-313/our-docker-files/actions/workflows/docker-compose-build.yml)

Well, the repo's name is descriptive enough. Please, DO NOT push our credentials here

- We use github Actions to build the docker compose itself and to check the yaml formatting
- For a local tests of CI workflows, consider using [Act](https://github.com/nektos/act)

### Launch Node exporter with docker compose
Don't forget to edit hostname value
```
curl -o docker-compose.yml https://raw.githubusercontent.com/admin-313/our-docker-files/main/compose-files/node-exporter/docker-compose.yml
```
```
sudo docker compose up -d
```

### Launch Grafana with Prometheus, ping exporter, node exporter and alertmanager with docker compose
Don't forget to put config files
```
curl -o docker-compose.yml https://raw.githubusercontent.com/admin-313/our-docker-files/main/compose-files/grafana-prometheus/docker-compose.yml
```
```
sudo docker compose up -d
```
