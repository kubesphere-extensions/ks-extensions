{{/*
Create chart name and version as used by the chart label.
*/}}
{{- define "extension.chart" -}}
{{- printf "%s-%s" .Chart.Name .Chart.Version | replace "+" "_" | trunc 63 | trimSuffix "-" }}
{{- end }}

{{/*
Common labels
*/}}
{{- define "extension.labels" -}}
helm.sh/chart: {{ include "extension.chart" . }}
app.kubernetes.io/name: devops-extension
app.kubernetes.io/instance: {{ .Release.Name }}
{{- if .Chart.AppVersion }}
app.kubernetes.io/version: {{ .Chart.AppVersion | quote }}
{{- end }}
app.kubernetes.io/managed-by: {{ .Release.Service }}
{{- end }}

{{- define "devops.name" -}}
{{- default .Chart.Name .Values.nameOverride | trunc 63 | trimSuffix "-" }}
{{- end }}

{{/*
Selector labels for apiserver
*/}}
{{- define "apiserver.selectorLabels" -}}
app.kubernetes.io/name: devops-extension
app.kubernetes.io/instance: {{ .Release.Name }}
devops.kubesphere.io/component: devops-apiserver
{{- end }}

{{/*
Common labels for apiserver
*/}}
{{- define "apiserver.labels" -}}
{{ include "extension.labels" . }}
devops.kubesphere.io/component: devops-apiserver
{{- end }}

{{/*
Returns the admin password
https://github.com/helm/charts/issues/5167#issuecomment-619137759
Add "the." prefix to avoid helm template failure 
*/}}
{{- define "the.jenkins.password" -}}
  {{- if .Values.jenkins.Master.AdminPassword -}}
    {{- .Values.jenkins.Master.AdminPassword | b64enc | quote }}
  {{- else -}}
    {{- $secret := (lookup "v1" "Secret" (default .Release.Namespace .Values.namespace) .Values.jenkins.fullnameOverride).data -}}
    {{- if $secret -}}
      {{/*
        Reusing current password since secret exists
      */}}
      {{- index $secret "jenkins-admin-password" -}}
    {{- else -}}
      {{/*
          Generate new password
      */}}
      {{- randAlphaNum 22 | b64enc | quote }}
    {{- end -}}
  {{- end -}}
{{- end -}}

{{/*
Returns the admin default api token
https://github.com/helm/charts/issues/5167#issuecomment-619137759
Add "the." prefix to avoid helm template failure 
*/}}
{{- define "the.jenkins.adminToken" -}}
  {{- if .Values.jenkins.Master.AdminToken -}}
    {{- .Values.jenkins.Master.AdminToken | b64enc | quote }}
  {{- else -}}
    {{- $secret := (lookup "v1" "Secret" (default .Release.Namespace .Values.namespace) .Values.jenkins.fullnameOverride).data -}}
    {{- if $secret -}}
      {{/*
        Reusing current password since secret exists
      */}}
      {{- index $secret "jenkins-admin-token" -}}
    {{- else -}}
      {{/*
          Generate new token
      */}}
      {{- randNumeric 32 | printf "11%s" | lower | b64enc | quote }}
    {{- end -}}
  {{- end -}}
{{- end -}}
