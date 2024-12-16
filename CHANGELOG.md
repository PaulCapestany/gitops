# CHANGELOG

## [0.2.0] - 2024-12-16
### Added
- Introduced a single Helm chart (`helm/bitiq`) that can manage multiple services in parallel.

### Changed
- Moved from a per-service (`helm/toy-service`) structure to a unified (`helm/bitiq`) structure.
- Updated templates and values files to use a `services:` array and a unified `appVersion` strategy.

### Removed
- Removed the old `helm/toy-service` directory.

### Notes
- This restructuring simplifies tracking and rolling back to known stable combinations of microservice versions.
- Future services can now be easily integrated into the single chart.