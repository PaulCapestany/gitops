# Setting up Tekton Triggers for toy-service

This document details how to configure GitHub webhooks and Tekton Triggers so that commits to the `toy-service` repo's `main` branch automatically start a new pipeline run.

## Prerequisites

- A running Kubernetes/OpenShift cluster with Tekton Pipelines and Tekton Triggers installed.
- `toy-service-build-pipeline` defined and working.
- `github-webhook-secret` Kubernetes secret created with your GitHub webhook secret.

## Steps

1. **Configure GitHub Webhook**
 - Go to toy-service repository settings on GitHub.
 - Navigate to “Webhooks” and click “Add webhook.”
 - Payload URL: Use the exposed URL of the EventListener (e.g., http://el-toy-service-listener-default.apps.wtf.bitiq.io).
 - Content type: application/json
 - Secret: Use the same secret value used in github-webhook-secret.
 - Which events?: Select “Just the push event.”
 - Save the webhook.
  
2. **Apply Tekton Triggers Resources**
   ```sh
   oc apply -f pipelines/triggers/interceptor-secret.yaml
   oc apply -f pipelines/triggers/trigger-binding.yaml
   oc apply -f pipelines/triggers/trigger-template.yaml
   oc apply -f pipelines/triggers/event-listener.yaml
   ```

3. **Expose the EventListener**
   ```sh
   # Create a route (if on OpenShift)
   oc expose service el-toy-service-listener
   ```

4. **Test the Integration**
 - Push a commit to main in the toy-service repo.
 - Check Tekton Pipelines (oc get pipelineruns) to see if a new run was triggered.
 - If using Argo CD Image Updater, after the pipeline completes and the image is pushed, Argo CD should detect the new tag and sync the dev environment accordingly.

5. **Troubleshooting**
 - If no pipeline run appears, check the EventListener logs:
   ```sh
   oc logs -l eventlistener=el-toy-service-listener -c event-listener
   ```