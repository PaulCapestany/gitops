# bitiq Helm Chart

This chart deploys multiple bitiq microservices as a unified set. By managing all services under a single Helm chart, we can:

- Track and rollback to known-good combinations of service versions easily.
- Use environment-specific values files (`values-dev.yaml`, `values-prod.yaml`) to manage different mixes of services in each environment.
- Integrate with Argo CD and Argo CD Image Updater for fully automated GitOps workflows.

## How It Works

- **services array**: In `values.yaml`, we define an array of services, each with a name, image repository, tag, replica count, and optional ingress settings.
- **Environment overrides**: `values-dev.yaml` and `values-prod.yaml` override the default settings for each environment (e.g., different image tags, replica counts).
- **Single Source of Truth**: By having one chart, `appVersion` can be updated to record the exact combination of service versions for a given deployment. Rollbacks become as simple as reverting to a previous git commit.
- **Extensible**: Add more services by adding entries to the `services` array and ensuring their configuration is reflected in the templates.

## Files

- `Chart.yaml`: Chart metadata. `appVersion` encodes the full service combination.
- `values.yaml`: Default values, including the `services` array and global defaults.
- `values-dev.yaml` / `values-prod.yaml`: Environment-specific overrides.
- `templates/*`: Rendered Kubernetes manifests for Deployments, Services, Ingress, and HPA, all generated from the `services` array.
- `tests/unittest.yaml`: Helm unittest tests to ensure correct rendering and structure.

## Usage

```bash
helm template dev ./bitiq -f ./bitiq/values-dev.yaml
helm template prod ./bitiq -f ./bitiq/values-prod.yaml