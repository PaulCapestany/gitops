# Changelog

## v0.2.15 - 2024-12-20

### feat: enable Kaniko layer caching for faster builds

Introduced a PVC (`pipelines/kaniko-cache-pvc.yaml`) for caching Kaniko layers.

Updated `pipelines/kaniko-build-and-push-task.yaml` to leverage Kaniko caching.

## v0.2.0 - 2024-12-16

- Introduced a single Helm chart (`helm/bitiq`) that can manage multiple services in parallel.
- Moved from a per-service (`helm/toy-service`) structure to a unified (`helm/bitiq`) structure.
- Updated templates and values files to use a `services:` array and a unified `appVersion` strategy.
- Removed the old `helm/toy-service` directory.
- This restructuring simplifies tracking and rolling back to known stable combinations of microservice versions.
- Future services can now be easily integrated into the single chart.