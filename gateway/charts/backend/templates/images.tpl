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
Return the proper controller image name
*/}}
{{- define "controller.image" -}}
{{ include "common.images.image" (dict "imageRoot" .Values.controller.image "global" .Values.global) }}
{{- end -}}

{{/*
Return the proper apiserver image name
*/}}
{{- define "apiserver.image" -}}
{{ include "common.images.image" (dict "imageRoot" .Values.apiserver.image "global" .Values.global) }}
{{- end -}}



{{/*
Return the proper Docker Image Registry Secret Names
*/}}
{{- define "imagePullSecrets" -}}
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
