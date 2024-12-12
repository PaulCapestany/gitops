# Prod Environment

This directory holds the Argo CD Application manifest for the production environment of toy-service.

- `toy-service-application.yaml` references the same Helm chart and uses `values-prod.yaml`.
- Updates here require a manual PR and review to ensure stable deployments.