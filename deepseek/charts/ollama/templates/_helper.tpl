{{- define "ollama.image" -}}
{{ include "common.images.image" (dict "imageRoot" .Values.server.image "global" .Values.global) }}
{{- end -}}

{{- define "nextchat.image" -}}
{{ include "common.images.image" (dict "imageRoot" .Values.chat.image "global" .Values.global) }}
{{- end -}}

{{- define "common.images.image" -}}
{{- $registryName := .global.imageRegistry -}}
{{- $repositoryName := .imageRoot.repository -}}
{{- $separator := ":" -}}
{{- $termination := .global.tag | toString -}}
{{- if .imageRoot.registry }}
    {{- $registryName = .imageRoot.registry -}}
{{- end -}}
{{- if .imageRoot.tag }}
    {{- $termination = .imageRoot.tag | toString -}}
{{- end -}}
{{- if .imageRoot.digest }}
    {{- $separator = "@" -}}
    {{- $termination = .imageRoot.digest | toString -}}
{{- end -}}
{{- printf "%s/%s%s%s" $registryName $repositoryName $separator $termination -}}
{{- end -}}

{{- define "common.images.pullPolicy" -}}
  {{- if .value.imagePullPolicy -}}
    {{- .value.pullPolicy }}
  {{- else if .global.imagePullPolicy }}
    {{- .global.imagePullPolicy }}
  {{- else -}}
    {{- printf "IfNotPresent" }}
  {{- end -}}
{{- end -}}

{{- define "common.images.pullSecrets" -}}
  {{- if .value.pullSecrets -}}
    {{- toYaml .value.imagePullSecrets }}
  {{- else if .global.imagePullSecrets }}
    {{- toYaml .global.imagePullSecrets }}
  {{- else -}}
    {{- printf "[]" }}
  {{- end -}}
{{- end -}}

{{- define "common.nodeSelector" -}}
  {{- if .value.nodeSelector -}}
    {{- toYaml .value.nodeSelector }}
  {{- else if .global.nodeSelector }}
    {{- toYaml .global.nodeSelector }}
  {{- else -}}
    {{- printf "{}" }}
  {{- end -}}
{{- end -}}

{{/*
Expand the name of the chart.
*/}}
{{- define "backend.name" -}}
{{- default .Chart.Name .Values.nameOverride | trunc 63 | trimSuffix "-" }}
{{- end }}

{{/*
Create a default fully qualified app name.
We truncate at 63 chars because some Kubernetes name fields are limited to this (by the DNS naming spec).
If release name contains chart name it will be used as a full name.
*/}}
{{- define "backend.fullname" -}}
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