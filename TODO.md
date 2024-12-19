# TODOs for gitops Repository

This document outlines planned enhancements and maintenance tasks for `gitops`.

## Guidelines

- **Semantic Versioning (SemVer)** and **Conventional Commits** rules as described in the global [CONTRIBUTING.md](./CONTRIBUTING.md).
  
- **Upon Completion:**  
  When a task is completed:
  - Remove it from `TODO.md`.
  - Update `CHANGELOG.md` with the version increment and commit message.

---

## Upcoming Tasks

### MINOR Enhancements (Non-Breaking Feature Additions)

- **feat: integrate pipeline manifests into Argo CD management**  
  Manage Tekton pipeline and trigger manifests via Argo CD Applications, ensuring changes are auto-synced.

- **feat: automate `appVersion` updates in Chart.yaml**  
  Dynamically update `appVersion` to reflect deployed microservice versions, improving traceability and rollback procedures.

- **feat: introduce policy checks for production deployments**  
  Implement OPA or Kyverno policies and integrate CI checks to prevent non-compliant changes from reaching production.

- **feat: integrate secret management with Vault**  
  Use External Secrets Operator to pull secrets from Vault, enhancing security and secret rotation practices.

### PATCH Improvements (Backward-Compatible Fixes, Docs, Chores)

- **docs: improve documentation consistency & clarity**  
  Add `docs/architecture.md`, cross-reference from `toy-service` README, and incorporate architecture diagrams for easier onboarding.

- **docs: add CONTRIBUTING.md with guidelines**  
  Outline branching, testing, and environment setup steps, making it easier for contributors to get started.

- **docs: add local development setup instructions**  
  Document `docs/local-development.md` for simulating the GitOps flow locally, using `kind` or `minikube`.

- **docs: add directory structure documentation**  
  Annotate `README.md` to explain the purpose of `helm/`, `environments/`, `pipelines/`, and `policies/` directories.

- **chore: integrate `alstr/todo-to-issue-action`**  
  Automate conversion of inline code TODOs into GitHub Issues, ensuring better task tracking and visibility.

### Long-Term Goals (Potential Future MAJOR or MINOR)