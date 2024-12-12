{{- define "toy-service.fullname" -}}
{{ include "toy-service.name" . }}
{{- end }}

{{- define "toy-service.name" -}}
{{ .Chart.Name }}
{{- end }}