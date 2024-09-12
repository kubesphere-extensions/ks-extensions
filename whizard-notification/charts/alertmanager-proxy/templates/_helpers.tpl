{{- define "proxy.namespaceOverride" -}}
  {{- if .Values.namespaceOverride -}}
    {{- .Values.namespaceOverride -}}
  {{- else -}}
    {{- .Release.Namespace -}}
  {{- end -}}
{{- end -}}


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

{{- define "common.tolerations" -}}
{{- $tolerations := default .Values.global.tolerations .Values.tolerations }}
{{- if $tolerations }}
      tolerations:
{{ toYaml $tolerations | indent 8 }}
{{- end }}
{{- end }}

{{- define "common.affinity" -}}
{{- $affinity := default .Values.global.affinity .Values.affinity }}
{{- if $affinity }}
      affinity:
{{ toYaml $affinity | indent 8 }}
{{- end }}
{{- end }}