{{- define "model.name" -}}
{{- printf "%s:%s" .repository .tag -}}
{{- end -}}

{{- define "model.fullname" -}}
{{- printf "%s/%s:%s" .registry .repository .tag -}}
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

