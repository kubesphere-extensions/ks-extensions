{{/*
Expand the name of the chart.
*/}}
{{- define "kube-events-exporter.name" -}}
{{- default .Chart.Name .Values.nameOverride | trunc 63 | trimSuffix "-" }}
{{- end }}

{{/*
Create a default fully qualified app name.
We truncate at 63 chars because some Kubernetes name fields are limited to this (by the DNS naming spec).
If release name contains chart name it will be used as a full name.
*/}}
{{- define "kube-events-exporter.fullname" -}}
{{- if .Values.fullnameOverride }}
{{- .Values.fullnameOverride | trunc 63 | trimSuffix "-" }}
{{- else }}
{{- $name := default .Chart.Name .Values.nameOverride }}
{{- if contains $name .Release.Name }}
{{- .Release.Name | trunc 63 | trimSuffix "-" }}
{{- else }}
{{- printf "%s-%s" .Release.Name $name | trunc 63 | trimSuffix "-" }}
{{- end }}
{{- end }}
{{- end }}

{{- define "kube-events-exporter.namespaceOverride" -}}
  {{- if .Values.namespaceOverride -}}
    {{- .Values.namespaceOverride -}}
  {{- else -}}
    {{- .Release.Namespace -}}
  {{- end -}}
{{- end -}}

{{/*
Create chart name and version as used by the chart label.
*/}}
{{- define "kube-events-exporter.chart" -}}
{{- printf "%s-%s" .Chart.Name .Chart.Version | replace "+" "_" | trunc 63 | trimSuffix "-" }}
{{- end }}

{{/*
Common labels
*/}}
{{- define "kube-events-exporter.labels" -}}
helm.sh/chart: {{ include "kube-events-exporter.chart" . }}
{{ include "kube-events-exporter.selectorLabels" . }}
{{- if .Chart.AppVersion }}
app.kubernetes.io/version: {{ .Chart.AppVersion | quote }}
{{- end }}
app.kubernetes.io/managed-by: {{ .Release.Service }}
{{- end }}

{{/*
Selector labels
*/}}
{{- define "kube-events-exporter.selectorLabels" -}}
app.kubernetes.io/name: {{ include "kube-events-exporter.fullname" . }}
app.kubernetes.io/instance: {{ .Release.Name }}
{{- end }}

{{/*
Create the name of the service account to use
*/}}
{{- define "kube-events-exporter.serviceAccountName" -}}
{{- if .Values.serviceAccount.create }}
{{- default (include "kube-events-exporter.fullname" .) .Values.serviceAccount.name }}
{{- else }}
{{- default "default" .Values.serviceAccount.name }}
{{- end }}
{{- end }}


{{- define "global.imageRegistry" -}}
{{- $registry := default .Values.global.imageRegistry .Values.imageRegistryOverride }}
  {{- if $registry -}}
    {{- printf "%s/" $registry -}}
  {{- end -}}
{{- end -}}


{{- define "common.nodeSelectors" -}}
{{- $selector := default .Values.global.nodeSelector .Values.nodeSelector }}
{{- if $selector }}
      nodeSelector:
{{ toYaml $selector | indent 8 }}
{{- end }}
{{- end }}

{{- define "common.tolerations" -}}
{{- $tolerations := default .Values.global.tolerations .Values.tolerations }}
{{- if $tolerations }}
      tolerations:
{{ toYaml $tolerations | indent 8 }}
{{- end }}
{{- end }}

{{- define "common.affinity" -}}
{{- $affinity := default .Values.global.affinity .Values.affinity }}
{{- if $affinity }}
      affinity:
{{ toYaml $affinity | indent 8 }}
{{- end }}
{{- end }}



{{- define "opensearch.bulk" }}
bulk:
{{- if and .Values.sinks.opensearch.index .Values.sinks.opensearch.index.prefix }}
  index: "{{ .Values.sinks.opensearch.index.prefix }}-{{ "{{ .timestring }}" }}"
{{- else }}
  index: "{{ "{{ .cluster }}-events-{{ .timestring }}" }}"
{{- end }}
{{- end }}