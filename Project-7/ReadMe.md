# Obserability and monitoring of application

Step 1

Docker + cAdvisor + Prometheus + Grafana

infrastructure/container metrics

<img width="946" height="241" alt="image" src="https://github.com/user-attachments/assets/bd803836-c3f6-4e44-b516-e658826c745c" />

<img width="912" height="323" alt="image" src="https://github.com/user-attachments/assets/2e2d8c7a-4a7e-4762-b07c-b3cf3b79ef72" />


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

