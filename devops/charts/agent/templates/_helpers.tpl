{{/*
Expand the name of the chart.
*/}}
{{- define "devops.name" -}}
{{- default .Chart.Name .Values.nameOverride | trunc 63 | trimSuffix "-" }}
{{- end }}

{{/*
Create chart name and version as used by the chart label.
*/}}
{{- define "ks-devops.chart" -}}
{{- printf "%s-%s" .Chart.Name .Chart.Version | replace "+" "_" | trunc 63 | trimSuffix "-" }}
{{- end }}

{{/*
Common labels for ks-devops
*/}}
{{- define "ks-devops.labels" -}}
helm.sh/chart: {{ include "ks-devops.chart" . }}
app.kubernetes.io/name: {{ include "devops.name" . }}
app.kubernetes.io/instance: {{ .Release.Name }}
{{- if .Chart.AppVersion }}
app.kubernetes.io/version: {{ .Chart.AppVersion | quote }}
{{- end }}
app.kubernetes.io/managed-by: {{ .Release.Service }}
{{- end }}

{{/*
Common labels for apiserver
*/}}
{{- define "apiserver.labels" -}}
{{ include "ks-devops.labels" . }}
devops.kubesphere.io/component: devops-apiserver
{{- end }}

{{/*
Selector labels for apiserver
*/}}
{{- define "apiserver.selectorLabels" -}}
app.kubernetes.io/name: {{ include "devops.name" . }}
app.kubernetes.io/instance: {{ .Release.Name }}
devops.kubesphere.io/component: devops-apiserver
{{- end }}

{{/*
Common labels for controller
*/}}
{{- define "controller.labels" -}}
{{ include "ks-devops.labels" . }}
devops.kubesphere.io/component: devops-controller
{{- end }}

{{/*
Selector labels for controller
*/}}
{{- define "controller.selectorLabels" -}}
app.kubernetes.io/name: {{ include "devops.name" . }}
app.kubernetes.io/instance: {{ .Release.Name }}
devops.kubesphere.io/component: devops-controller
{{- end }}

{{- define "apiserver.ownedByExtension" -}}
{{- with (lookup "apps/v1" "Deployment" (default .Release.Namespace .Values.global.namespace) "devops-apiserver") }}
{{- range $key, $value := .metadata.annotations }}
{{- if eq $key "meta.helm.sh/release-name" }}
{{- if eq $value "devops" }}
{{- print "true" }}
{{- else }}
{{- print "false" }}
{{- end }}
{{- end }}
{{- end }}
{{- end }}
{{- end }}

{{- define "devops-config.ownedByExtension" -}}
{{- with (lookup "v1" "ConfigMap" (default .Release.Namespace .Values.global.namespace) "devops-config") }}
{{- range $key, $value := .metadata.annotations }}
{{- if eq $key "meta.helm.sh/release-name" }}
{{- if eq $value "devops" }}
{{- print "true" }}
{{- else }}
{{- print "false" }}
{{- end }}
{{- end }}
{{- end }}
{{- end }}
{{- end }}

{{- define "roletemplate.ownedByExtension" -}}
{{- with (lookup "iam.kubesphere.io/v1beta1" "RoleTemplate" "" "devops-view-credentials") }}
{{- range $key, $value := .metadata.annotations }}
{{- if eq $key "meta.helm.sh/release-name" }}
{{- if eq $value "devops" }}
{{- print "true" }}
{{- else }}
{{- print "false" }}
{{- end }}
{{- end }}
{{- end }}
{{- end }}
{{- end }}

{{- define "serviceaccount.ownedByExtension" -}}
{{- with (lookup "v1" "ServiceAccount" (default .Release.Namespace .Values.global.namespace) .Values.serviceAccount.name) }}
{{- range $key, $value := .metadata.annotations }}
{{- if eq $key "meta.helm.sh/release-name" }}
{{- if eq $value "devops" }}
{{- print "true" }}
{{- else }}
{{- print "false" }}
{{- end }}
{{- end }}
{{- end }}
{{- end }}
{{- end }}

{{- define "apiservice.ownedByExtension" -}}
{{- with (lookup "extensions.kubesphere.io/v1alpha1" "APIService" "" "v1alpha3.devops.kubesphere.io") }}
{{- range $key, $value := .metadata.annotations }}
{{- if eq $key "meta.helm.sh/release-name" }}
{{- if eq $value "devops" }}
{{- print "true" }}
{{- else }}
{{- print "false" }}
{{- end }}
{{- end }}
{{- end }}
{{- end }}
{{- end }}
