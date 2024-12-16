# TODOs for GitOps Repository

This document tracks actionable tasks and improvements for the GitOps repository and associated workflows.  
They are grouped by priority, acknowledging that some tasks depend on having foundational elements fully working before adding complexity.

---

### High Priority

1. **Restructure to a Single Helm Chart for All Services**
   - **Goal**: Move from a per-service or toy-service-centric approach to a single Helm chart that can deploy multiple bitiq microservices together. This single chart will:
     - Make it easier to track and rollback to known stable combinations of service versions.
     - Provide a single source of truth for the entire environment’s deployed state.
   - **Tasks**:
     - Consolidate the `helm/` directory into a single `helm/bitiq/` chart.
     - Update templates to loop over a `services:` array defined in values files.
     - Adjust `values-dev.yaml` and `values-prod.yaml` to list all services and their image tags.
     - Update `appVersion` logic to encode all service versions in a single string.
     - Sanity-check the impact on Argo CD Applications, CI/CD pipelines, and rollback flows.
   - **Outcome**: A unified deployment model that simplifies environment rollbacks, auditing, and contributor understanding.

2. **Automate Pipeline Triggers from toy-service Repo Commits**  
   - **Goal**: Ensure that any new commit to `toy-service` (and eventually other services) automatically triggers the Tekton pipeline, producing a new image.  
   - **Tasks**:
     - Create Tekton TriggerBindings, TriggerTemplates, and EventListeners.
     - Configure a GitHub webhook on the `toy-service` repo to call the EventListener endpoint.
     - Validate that pushing a commit to `toy-service` main branch starts the pipeline.
   - **Outcome**: Fully automated CI: commit → build → deploy → Git update.

3. **Argo CD Image Updater Git Integration**
   - **Goal**: Ensure that Git remains the single source of truth.
   - **Tasks**:
     - Add Git credentials as a Kubernetes Secret for Argo CD Image Updater.
     - Update Argo CD Image Updater configuration so it commits image tag changes to this repo.
   - **Outcome**: Closed-loop GitOps workflow where the repo and cluster remain in sync.

4. **Documentation Consistency & Clarity**
   - **Goal**: Provide unified, high-quality documentation for easier onboarding.
   - **Tasks**:
     - Cross-reference this `gitops` repo from the `toy-service` repo (and vice versa).
     - Add architecture diagrams and explain directory structures (`helm/`, `environments/`, `pipelines/`, `policies/`).
   - **Outcome**: Lower barrier to entry and clearer understanding of how repos interrelate.

---

### Medium Priority

5. **Automated appVersion Updates & Naming Convention**
   - **Goal**: Automate `appVersion` updates in the Helm chart to include semantic versions and commit hashes for all services.
   - **Tasks**:
     - Implement a CI script to parse version tags and short commit SHAs for each service.
     - Update `Chart.yaml`’s `appVersion` automatically before Helm upgrades.
   - **Outcome**: Improved traceability and simpler rollbacks.

6. **Contributor Guide**
   - **Goal**: Develop a `CONTRIBUTING.md` detailing how to propose changes, run tests, and navigate the codebase.
   - **Tasks**:
     - Include branching strategies, semantic versioning rules, and testing instructions.
     - Add a high-level architecture overview and references to `toy-service` and other services.
   - **Outcome**: Easier onboarding and higher-quality contributions.

7. **Future Policy Checks for Prod Deployments**
   - **Goal**: Introduce automated policy checks (e.g., OPA, Kyverno) before promoting changes to prod.
   - **Tasks**:
     - Add initial policy files under `policies/`.
     - Integrate policy checking into CI workflows.
   - **Outcome**: More secure, predictable production deployments.

---

### Lower Priority / Post-Basics

8. **Secret Management with Vault**
   - **Goal**: Replace static secrets with Vault for better security and rotation.
   - **Tasks**:
     - Integrate External Secrets Operator or similar.
     - Update Helm charts to reference Vault-managed secrets.
   - **Outcome**: Enhanced security posture and compliance.

9. **Local Development Experience**
   - **Goal**: Improve local dev setup, allowing contributors to run and test services locally without a full Kubernetes stack.
   - **Tasks**:
     - Provide `docs/local-development.md` with guidance.
     - Potentially add a `docker-compose` setup for minimal local testing.
   - **Outcome**: Faster iteration and easier debugging for contributors.

10. **Refine Directory Structures (If Needed)**
    - **Goal**: Document reasoning behind directory layouts after restructuring for a single chart.
    - **Tasks**:
      - Add a short explanation in `README.md` detailing each directory’s purpose.
    - **Outcome**: Better contributor understanding of repo organization.

11. **Integrate `alstr/todo-to-issue-action` for TODO Management**
    - **Goal**: Automatically convert `TODO:` comments in the codebase into GitHub issues, linking them into the development workflow.
    - **Tasks**:
      - Add and configure `alstr/todo-to-issue-action` GitHub Action.
      - Optionally integrate with GitHub Projects to categorize and prioritize these automatically created issues.
    - **Outcome**: Easier tracking of code-level TODOs, ensuring they don’t get lost and can be managed alongside other issues.
    - **Note**: This is a “nice to have” after the foundational CI/CD and GitOps loops are stable.

---

**Note:** Priorities and tasks may shift as the project evolves. Revisit this list periodically to adjust priorities and add/remove tasks as needed.