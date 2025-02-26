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