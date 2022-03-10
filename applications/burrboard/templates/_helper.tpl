{{/*
Create chart name and version as used by the chart label.
*/}}
{{- define "burrboard.chart" -}}
{{- printf "%s-%s" .Chart.Name .Chart.Version | replace "+" "_" | trunc 63 | trimSuffix "-" }}
{{- end }}

{{- define "burrboard.labels" }}
{{ include "burrboard.selectorLabels" . }}
{{- if .root.Chart.AppVersion }}
app.kubernetes.io/version: {{ .root.Chart.AppVersion | quote }}
{{- end }}
app.kubernetes.io/managed-by: {{ .root.Release.Service }}
{{- end }}

{{- define "burrboard.selectorLabels" }}
app.kubernetes.io/name: {{ .name }}
app.kubernetes.io/component: {{ .component }}
app.kubernetes.io/instance: {{ .root.Values.coreReleaseName | default .root.Release.Name }}
{{- end }}

{{- define "burrboard.timescaledb.host" }}
{{- if .Values.tsdb.timescale.deployment.enabled }}
timescaledb
{{- else }}
{{- .Values.tsdb.timescale.host }}
{{- end }}
{{- end }}

{{- define "burrboard.timescaledb.port" }}
{{- if .Values.tsdb.timescale.deployment.enabled }}
5432
{{- else }}
{{- .Values.tsdb.timescale.port }}
{{- end }}
{{- end }}
