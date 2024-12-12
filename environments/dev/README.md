# Dev Environment

This directory holds the Argo CD Application manifest for the dev environment of toy-service.

- `toy-service-application.yaml` references the Helm chart in the main repo.
- We override values with `values-dev.yaml` within the chart directory.
- Argo CD Image Updater will update this environment automatically upon new dev images.