{{- define "bitiq.fullname" -}}
{{ include "bitiq.name" . }}
{{- end }}

{{- define "bitiq.name" -}}
{{ .Chart.Name }}
{{- end }}

{{- define "bitiq.labels" -}}
app.kubernetes.io/name: {{ include "bitiq.name" . }}
app.kubernetes.io/instance: {{ .Release.Name }}
app.kubernetes.io/version: {{ .Chart.AppVersion | quote }}
app.kubernetes.io/part-of: bitiq
{{- end }}