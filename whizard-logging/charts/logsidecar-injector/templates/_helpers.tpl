{{/* vim: set filetype=mustache: */}}
{{/*
Expand the name of the chart.
*/}}
{{- define "logsidecar-injector.name" -}}
{{- default .Chart.Name .Values.nameOverride | trunc 63 | trimSuffix "-" -}}
{{- end -}}

{{/*
Create a default fully qualified app name.
We truncate at 63 chars because some Kubernetes name fields are limited to this (by the DNS naming spec).
If release name contains chart name it will be used as a full name.
*/}}
{{- define "logsidecar-injector.fullname" -}}
{{- if .Values.fullnameOverride -}}
{{- .Values.fullnameOverride | trunc 63 | trimSuffix "-" -}}
{{- else -}}
{{- $name := default .Chart.Name .Values.nameOverride -}}
{{- if contains $name .Release.Name -}}
{{- .Release.Name | trunc 63 | trimSuffix "-" -}}
{{- else -}}
{{- printf "%s-%s" .Release.Name $name | trunc 63 | trimSuffix "-" -}}
{{- end -}}
{{- end -}}
{{- end -}}

{{/*
Allow the release namespace to be overridden for multi-namespace deployments in combined charts
*/}}
{{- define "logsidecar-injector.namespace" -}}
  {{- if .Values.namespaceOverride -}}
    {{- .Values.namespaceOverride -}}
  {{- else -}}
    {{- .Release.Namespace -}}
  {{- end -}}
{{- end -}}

{{/*
Create chart name and version as used by the chart label.
*/}}
{{- define "logsidecar-injector.chart" -}}
{{- printf "%s-%s" .Chart.Name .Chart.Version | replace "+" "_" | trunc 63 | trimSuffix "-" -}}
{{- end -}}

{{/*
Common labels
*/}}
{{- define "logsidecar-injector.labels" -}}
helm.sh/chart: {{ include "logsidecar-injector.chart" . }}
{{- if .Chart.AppVersion }}
app.kubernetes.io/version: {{ .Chart.AppVersion | quote }}
{{- end }}
app.kubernetes.io/managed-by: {{ .Release.Service }}
app.kubernetes.io/name: {{ include "logsidecar-injector.name" . }}
app.kubernetes.io/instance: {{ .Release.Name }}
{{- end -}}

{{/* Fullname suffixed with deploy */}}
{{- define "logsidecar-injector.deploy.fullname" -}}
{{- printf "%s-deploy" (include "logsidecar-injector.fullname" .) -}}
{{- end }}

{{/* Fullname suffixed with admission */}}
{{- define "logsidecar-injector.admission.fullname" -}}
{{- printf "%s-admission" (include "logsidecar-injector.fullname" .) -}}
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

{{- define "common.affinity" -}}
{{- $affinity := default .Values.global.affinity .Values.affinity }}
{{- if $affinity }}
      affinity:
{{ toYaml $affinity | indent 8 }}
{{- end }}
{{- end }}

{{- define "common.tolerations" -}}
{{- $tolerations := default .Values.global.tolerations .Values.tolerations }}
{{- if $tolerations }}
      tolerations:
{{ toYaml $tolerations | indent 8 }}
{{- end }}
{{- end }}