# GitOps Repository

This repository manages the deployment of the bitiq microservices (including toy-service) using GitOps principles. It leverages:
- A single Helm chart (located in `helm/toy-service`) to deploy services to multiple environments (dev, prod) via separate values files.
- Argo CD for continuous delivery and synchronization of Kubernetes manifests from this repo to the cluster.
- Argo CD Image Updater to automatically update the image tags when new versions are pushed to the registry.
- (Planned) Tekton-based OpenShift Pipelines to build, test, and push images to Quay.io.

**Key Concepts:**
- **Single Helm Chart:**  
  The chart in `helm/toy-service` defines templates for deployments, services, ingresses, etc. `values.yaml` holds shared defaults. `values-dev.yaml` and `values-prod.yaml` override these defaults for each environment.
- **Environments Directories (`environments/dev`, `environments/prod`):**  
  Each environment has its own Argo CD Application manifest referencing the Helm chart and the appropriate values files. `kustomization.yaml` files can be used if you wish to layer additional configurations.
- **Argo CD Image Updater (`argocd-image-updater`)**:  
  This detects new images in Quay.io and updates the environment manifests accordingly.

**Getting Started:**
1. **Set Up Argo CD:**  
   Point Argo CD at this repository. Sync the `environments/dev` directory for the dev environment and `environments/prod` directory for the prod environment.
2. **Set Up CI Pipeline:**  
   A Tekton pipeline (`pipelines/toy-service-build-pipeline.yaml`) is provided as a reference for building and pushing images to Quay.io. Integrate it with your OpenShift cluster.
3. **Secrets Management with Vault:**  
   Integrate External Secrets Operator or a similar mechanism to pull secrets from Vault and inject them into the cluster. Update the Helm chart to reference these secrets as needed.

**Contributing & Access Control:**
- Developer contributions to toy-service code happen in the toy-service app repo.
- Once CI passes and images are pushed to Quay.io, Argo CD Image Updater automatically updates the dev environment manifests.
- Production changes require a PR against the `environments/prod/` manifests. Protected branches and CODEOWNERS can ensure only trusted maintainers can approve merges.

**Testing:**
- `helm unittest` tests are defined in `helm/toy-service/tests/unittest.yaml`.
- The GitHub workflow in `.github/workflows/ci-checks.yaml` runs linting (e.g., `helm lint`, `kubeconform`) and unit tests on PRs.

**Rollback:**
- Using Helm-based deployments allows you to track revisions. Rollback can be done by reverting to a previous commit in this repo and syncing Argo CD.

**Future Expansion:**
- Add more services by creating additional charts or extending the existing chart.
- Add more environments with their own directories and values files.
  - Integrate policy-as-code tools (OPA, Kyverno) under `policies/`.