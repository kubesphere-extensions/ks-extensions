{{/*
Return the proper image name
*/}}
{{- define "apiserver.image" -}}
{{ include "common.images.image" (dict "imageRoot" .Values.apiserver.image "global" .Values.global) }}
{{- end -}}

{{- define "controller.image" -}}
{{ include "common.images.image" (dict "imageRoot" .Values.controller.image "global" .Values.global) }}
{{- end -}}

{{- define "common.images.image" -}}
{{- $registryName := .imageRoot.registry -}}
{{- if .global.imageRegistry }}
    {{- $registryName = .global.imageRegistry -}}
{{- end -}}
{{- $separator := ":" -}}
{{- $termination := .imageRoot.tag | toString -}}
{{- if .global.tag }}
    {{- $termination = .global.tag | toString -}}
{{- end -}}
{{- if .imageRoot.digest }}
    {{- $separator = "@" -}}
    {{- $termination = .imageRoot.digest | toString -}}
{{- end -}}
{{- $repositoryName := .imageRoot.repository -}}
{{- printf "%s/%s%s%s" $registryName $repositoryName $separator $termination -}}
{{- end -}}

{{/*
Return the proper Docker Image Registry Secret Names
*/}}
{{- define "apiserver.imagePullSecrets" -}}
{{- include "common.images.pullSecrets" (dict "images" (list .Values.apiserver.image) "global" .Values.global) -}}
{{- end -}}

{{- define "controller.imagePullSecrets" -}}
{{- include "common.images.pullSecrets" (dict "images" (list .Values.controller.image) "global" .Values.global) -}}
{{- end -}}

{{- define "common.images.pullSecrets" -}}
  {{- $pullSecrets := list }}

  {{- if .global }}
    {{- range .global.imagePullSecrets -}}
      {{- $pullSecrets = append $pullSecrets . -}}
    {{- end -}}
  {{- end -}}

  {{- range .images -}}
    {{- range .pullSecrets -}}
      {{- $pullSecrets = append $pullSecrets . -}}
    {{- end -}}
  {{- end -}}

  {{- if (not (empty $pullSecrets)) }}
imagePullSecrets:
    {{- range $pullSecrets }}
  - name: {{ . }}
    {{- end }}
  {{- end }}
{{- end -}}
