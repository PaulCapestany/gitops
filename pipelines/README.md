# Pipelines

This directory contains sample Tekton pipeline definitions to:
- Build the toy-service image from the application repo
- Run tests and lint checks
- Push the image to Quay.io
- Trigger Argo CD sync (if desired)

These pipelines should be applied to the OpenShift cluster and integrated with the toy-service repo's webhook triggers.

Purpose of files:
- `quay-secret.yaml`: Stores Quay credentials for pushing images.
- `pipeline-serviceaccount.yaml`: A ServiceAccount that the pipeline uses, referencing the Quay secret.
- `run-tests-task.yaml`: A Tekton Task to run helm lint, helm unittest, and kubeconform checks.
- `build-and-push-task.yaml`: A Tekton Task using buildah to build and push the image to Quay.
- `toy-service-build-pipeline.yaml`: Defines the pipeline composed of git-clone (official Tekton task), run-tests-task, and build-and-push-task.
- `pipeline-run-sample.yaml`: An example PipelineRun showing how you might manually trigger the pipeline.
- `k8s-rbac.yaml`: Example RBAC resources if needed. In many cases, OpenShift Pipelines will create the needed roles automatically, but we show an example for completeness.