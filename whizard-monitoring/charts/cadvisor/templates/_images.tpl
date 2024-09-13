{{- define "cadvisor.common.image.gen" -}}
{{- $registryName := "" }}
{{- if and .global .global.imageRegistry }}
    {{- $registryName = .global.imageRegistry }}
{{- end }}
{{- if .imageRoot.registry }}
    {{- $registryName = .imageRoot.registry -}}
{{- end -}}
{{- if empty $registryName }}
    {{- if .imageRoot.defaultRegistry }}
        {{- $registryName = .imageRoot.defaultRegistry }}
    {{- end -}}
{{- end -}}

{{- $repositoryName := .imageRoot.repository -}}

{{- $separator := ":" -}}
{{- $termination := "" -}}
{{- if and .global .global.tag }}
    {{- $termination = .global.tag | toString }}
{{- end }}
{{- if .imageRoot.tag }}
    {{- $termination = .imageRoot.tag | toString -}}
{{- end -}}
{{- if .imageRoot.digest }}
    {{- $separator = "@" -}}
    {{- $termination = .imageRoot.digest | toString -}}
{{- end -}}

{{- if $registryName }}
    {{- printf "%s/%s%s%s" $registryName $repositoryName $separator $termination -}}
{{- else }}
    {{- printf "%s%s%s" $repositoryName $separator $termination -}}
{{- end }}
{{- end -}}

{{/*
Create the image of the cadvisor to use
*/}}
{{- define "cadvisor.image" -}}
{{- $_dict := dict "imageRoot" .Values.image "global" .Values.global }}
{{- if empty $_dict.imageRoot.tag }}
    {{- $_ := set $_dict.imageRoot "tag" (printf "v%s" .Chart.AppVersion) }}
{{- end }}
{{- include "cadvisor.common.image.gen" $_dict -}}
{{- end -}}