# Pipelines

This directory contains sample Tekton pipeline definitions to:
- Build the toy-service image from the application repo
- Run tests and lint checks
- Push the image to Quay.io
- Trigger Argo CD sync (if desired)

These pipelines should be applied to the OpenShift cluster and integrated with the toy-service repo's webhook triggers.