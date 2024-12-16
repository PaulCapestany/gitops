# TODOs for GitOps Repository

This document tracks actionable tasks and improvements for the GitOps repository.  
Revisit this list regularly as priorities and tasks may change.

---

### High Priority

1. **Argo CD Image Updater Git Integration**  
   - **Goal**: Ensure image updates commit changes back to this repo, keeping Git as the source of truth.  
   - **Tasks**:
     - [ ] Add Git credentials as a Kubernetes Secret (if not done).
     - [ ] Confirm Argo CD Image Updater config commits updated image tags to `environments/dev` manifests.
     - [ ] Test the workflow: push a new image tag to Quay → verify updated manifests in Git → Argo CD syncs cluster.
   - **Related Docs**: [Argo CD Image Updater](https://argocd-image-updater.readthedocs.io/)
   - **Outcome**: Full GitOps loop ensuring manifests in Git reflect the running state.

2. **Documentation Consistency & Clarity**  
   - **Goal**: Improve on-boarding experience.  
   - **Tasks**:
     - [ ] Add `docs/architecture.md` with a system diagram of commit-to-prod flow.
     - [ ] Cross-reference `gitops` from `toy-service` README, so contributors know where to find deployment logic.
     - [ ] Integrate architecture diagrams in `README.md` or `docs/`.
   - **Outcome**: Clearer understanding and faster contributor onboarding.

---

### Medium Priority

3.  **Integrate Pipeline Manifests into Argo CD Management**
   - **Goal**: Ensure that Tekton pipeline and trigger manifests are also managed by Argo CD, eliminating the need for manual `oc apply` steps.
   - **Tasks**:
     - [ ] Create a new Argo CD Application resource referencing the `pipelines/` directory.
     - [ ] Commit the Application YAML to `gitops` so Argo CD can sync Tekton resources automatically.
     - [ ] Confirm that changes to pipeline manifests in `pipelines/` are reflected in the cluster without manual intervention.
   - **Outcome**: Pipelines and triggers become fully GitOps-managed, ensuring a consistent, automated workflow.
  
4. **Automated `appVersion` Updates in Chart.yaml**  
   - **Goal**: Dynamically update `appVersion` with all service versions.  
   - **Tasks**:
     - [ ] Add a script (e.g., in Tekton pipeline) that gathers service versions and commit hashes.
     - [ ] Update `Chart.yaml` before `helm upgrade` to track exact versions deployed.
   - **Outcome**: Easier debugging and rollbacks.

5. **Contributor Guide (`CONTRIBUTING.md`)**  
   - **Goal**: Provide guidelines for contributors.  
   - **Tasks**:
     - [ ] Write `CONTRIBUTING.md` covering branching, testing, and environment setup.
     - [ ] Reference `TODO.md` and `docs/` for architecture details.
   - **Outcome**: Smooth contributor onboarding.

6. **Policy Checks for Production Deployments**  
   - **Goal**: Enforce policies before deploying to production.  
   - **Tasks**:
     - [ ] Introduce OPA or Kyverno policy files in `policies/`.
     - [ ] Add CI step to check compliance before merging PRs to `environments/prod`.
   - **Outcome**: More secure and compliant deployments.

---

### Lower Priority / Post-Basics

8. **Secret Management with Vault**  
   - **Goal**: Externalize secrets from manifests.  
   - **Tasks**:
     - [ ] Integrate External Secrets Operator.
     - [ ] Update Helm charts to pull secrets from Vault references.
   - **Outcome**: Enhanced security and secret rotation practices.

9. **Local Development Setup**  
   - **Goal**: Simplify local testing.  
   - **Tasks**:
     - [ ] Add `docs/local-development.md`.
     - [ ] Consider `kind` or `minikube` guide for running `helm template` and `argocd` locally.
   - **Outcome**: Faster iteration and contributor confidence before pushing changes.

10. **Directory Structure Documentation**  
    - **Goal**: Explain directory layout.  
    - **Tasks**:
      - [ ] Add notes in `README.md` explaining the purpose of `helm/`, `environments/`, `pipelines/`, and `policies/`.
    - **Outcome**: Greater clarity for newcomers.

11. **Integrate `alstr/todo-to-issue-action`**  
    - **Goal**: Track code-level TODOs as GitHub Issues automatically.  
    - **Tasks**:
      - [ ] Configure `alstr/todo-to-issue-action`.
      - [ ] Integrate with GitHub Projects to track tasks.
    - **Outcome**: Streamlined task management, ensuring TODOs in code don’t get lost.

---

**Note:** Update this list as tasks are completed or new priorities emerge.