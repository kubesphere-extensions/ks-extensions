{{/*
Return the proper image name
*/}}
{{- define "gatekeeper.image" -}}
{{ include "common.images.image" (dict "imageRoot" .Values.image "global" .Values.global) }}
{{- end -}}

{{- define "preInstall.crdRepository.image" -}}
{{ include "common.images.image" (dict "imageRoot" .Values.preInstall.crdRepository.image "global" .Values.global) }}
{{- end -}}

{{- define "postInstall.labelNamespace.image" -}}
{{ include "common.images.image" (dict "imageRoot" .Values.postInstall.labelNamespace.image "global" .Values.global) }}
{{- end -}}

{{- define "postUpgrade.labelNamespace.image" -}}
{{ include "common.images.image" (dict "imageRoot" .Values.postUpgrade.labelNamespace.image "global" .Values.global) }}
{{- end -}}

{{- define "preUninstall.deleteWebhookConfigurations.image" -}}
{{ include "common.images.image" (dict "imageRoot" .Values.preUninstall.deleteWebhookConfigurations.image "global" .Values.global) }}
{{- end -}}

{{- define "postInstall.probeWebhook.image" -}}
{{ include "common.images.image" (dict "imageRoot" .Values.postInstall.probeWebhook.image "global" .Values.global) }}
{{- end -}}

{{/*
Return the proper image name
{{ include "common.images.image" ( dict "imageRoot" .Values.path.to.the.image "global" .Values.global ) }}
*/}}
{{- define "common.images.image" -}}
{{- $registryName := .imageRoot.registry -}}
{{- $repositoryName := .imageRoot.repository -}}
{{- $separator := ":" -}}
{{- $termination := .imageRoot.tag | toString -}}
{{- if .global }}
    {{- if .global.imageRegistry }}
     {{- $registryName = .global.imageRegistry -}}
    {{- end -}}
{{- end -}}
{{- if .imageRoot.digest }}
    {{- $separator = "@" -}}
    {{- $termination = .imageRoot.digest | toString -}}
{{- end -}}
{{- if $registryName }}
    {{- printf "%s/%s%s%s" $registryName $repositoryName $separator $termination -}}
{{- else -}}
    {{- printf "%s%s%s"  $repositoryName $separator $termination -}}
{{- end -}}
{{- end -}}
