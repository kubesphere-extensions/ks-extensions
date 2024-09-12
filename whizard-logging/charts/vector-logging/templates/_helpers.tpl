{{/*namespace*/}}
{{- define "logging.namespaceOverride" -}}
  {{- if .Values.namespaceOverride -}}
    {{- .Values.namespaceOverride -}}
  {{- else -}}
    {{- .Release.Namespace -}}
  {{- end -}}
{{- end -}}

{{/*
Expand the name of the chart.
*/}}
{{- define "logging.name" -}}
{{- default .Chart.Name .Values.nameOverride | trunc 63 | trimSuffix "-" }}
{{- end }}

{{/*
Create chart name and version as used by the chart label.
*/}}
{{- define "logging.chart" -}}
{{- printf "%s-%s" .Chart.Name .Chart.Version | replace "+" "_" | trunc 63 | trimSuffix "-" }}
{{- end }}

{{/*
Selector labels
*/}}
{{- define "logging.selectorLabels" -}}
app.kubernetes.io/name: {{ include "logging.name" . }}
app.kubernetes.io/instance: {{ .Release.Name }}
{{- end }}

{{/*
Common labels
*/}}
{{- define "logging.labels" -}}
helm.sh/chart: {{ include "logging.chart" . }}
logging.whizard.io/component: "logs"
logging.whizard.io/vector-role: Agent
logging.whizard.io/enable: "true"
{{ include "logging.selectorLabels" . }}
{{- if .Chart.AppVersion }}
app.kubernetes.io/version: {{ .Chart.AppVersion | quote }}
{{- end }}
app.kubernetes.io/managed-by: {{ .Release.Service }}
{{- end }}

{{/*cluster name*/}}
{{- define "logging.clusterInfo.name" -}}
  {{- if eq .Values.global.clusterInfo.role "host" }}
    print "host"
  {{- else -}}
    {{- .Values.global.clusterInfo.name -}}
  {{- end -}}
{{- end -}}

{{- define "opensearch.bulk" }}
bulk:
{{- if and .Values.sinks.opensearch.index .Values.sinks.opensearch.index.prefix }}
  index: "{{ .Values.sinks.opensearch.index.prefix }}-{{ "{{ .timestring }}" }}"
{{- else }}
  index: "{{ "{{ .cluster }}-logs-{{ .timestring }}" }}"
{{- end }}
{{- end }}