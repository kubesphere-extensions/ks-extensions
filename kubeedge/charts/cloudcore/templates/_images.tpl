{{/*
Return the proper image name
*/}}
{{- define "cloudCore.image" -}}
{{ include "common.images.image" (dict "imageRoot" .Values.cloudCore.image "global" .Values.global) }}
{{- end -}}

{{- define "iptablesManager.image" -}}
{{ include "common.images.image" (dict "imageRoot" .Values.iptablesManager.image "global" .Values.global) }}
{{- end -}}

{{- define "controllerManager.image" -}}
{{ include "common.images.image" (dict "imageRoot" .Values.controllerManager.image "global" .Values.global) }}
{{- end -}}

{{- define "kubeEdgeProxy.image" -}}
{{ include "common.images.image" (dict "imageRoot" .Values.kubeEdgeProxy.image "global" .Values.global) }}
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

{{/*
Return the proper Docker Image Registry Secret Names
*/}}
{{- define "backend.imagePullSecrets" -}}
{{- include "common.images.pullSecrets" (dict "pullSecrets" .Values.imagePullSecrets "global" .Values.global) -}}
{{- end -}}

{{- define "common.images.pullSecrets" -}}
  {{- $pullSecrets := list }}

  {{- if .global }}
    {{- range .global.imagePullSecrets -}}
      {{- $pullSecrets = append $pullSecrets . -}}
    {{- end -}}
  {{- end -}}

  {{- range .pullSecrets -}}
    {{- $pullSecrets = append $pullSecrets . -}}
  {{- end -}}

  {{- if (not (empty $pullSecrets)) }}
imagePullSecrets:
    {{- range $pullSecrets }}
  - name: {{ . }}
    {{- end }}
  {{- end }}
{{- end -}}