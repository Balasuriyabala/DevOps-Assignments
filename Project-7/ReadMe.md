# Obserability and monitoring of application

Step 1

Docker + cAdvisor + Prometheus

→ infrastructure/container metrics

Step 2

Application Prometheus metrics

→ HTTP request rate, latency, errors

Step 3

Loki + log collection

→ centralized Docker/application logs

Step 4

OpenTelemetry Collector

→ telemetry pipeline

Step 5

Tempo + OpenTelemetry tracing

→ distributed traces

Step 6

Grafana correlation

→ Metrics → Logs → Traces

Step 7

Alertmanager

→ production alerts

Step 8

Build a complete SRE dashboard

