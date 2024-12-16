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

## Versioning & Naming Conventions

The `appVersion` field in `Chart.yaml` encodes the versions of all microservices currently deployed.

**Format:**
- For a single service: `<serviceName>-<semver>-<commitHash>`
- For multiple services: join each service entry with an underscore (`_`).

**Example:**
`toy-service-0.2.1-0bf65de_service-A-0.1.2-abc1234_service-B-0.3.0-xyz1234`

**Allowed Characters:**
- Only alphanumeric characters (`[A-Za-z0-9]`), `-`, `_`, and `.` are allowed.
- No colons `:` or other special characters that would break Kubernetes label rules.

**Rationale:**
- This ensures `appVersion` can be safely included as a label without violating Kubernetes naming conventions.
- It also makes rollbacks and auditing simpler by providing a clear record of the exact versions of all services at any given time.

Future CI/CD automation will handle updating `appVersion` automatically, ensuring that every deployment reflects the current mix of microservice versions.

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