{{/* Core Resource Configuration Template */}}
{{- define "deepseek.resources" -}}
{{- if .Values.server.resources }}
{{ toYaml .Values.server.resources }}
{{- else if eq .Values.model.repository "deepseek-r1" }}
requests:
  cpu: {{ include "deepseek.request.cpu" .Values.model.tag }}
  memory: {{ include "deepseek.request.memory" .Values.model.tag }}
  {{- if .Values.enableAMD }}
  amd.com/gpu: {{ include "deepseek.amd.gpu" .Values.model.tag }}
  {{- else if .Values.enableNvidia }}
  nvidia.com/gpu: {{ include "deepseek.nvidia.gpu" .Values.model.tag }}
  {{- end }}
limits:
  cpu: {{ include "deepseek.limit.cpu" .Values.model.tag }}
  memory: {{ include "deepseek.limit.memory" .Values.model.tag }}
  {{- if .Values.enableAMD }}
  amd.com/gpu: {{ include "deepseek.amd.gpu" .Values.model.tag }}
  {{- else if .Values.enableNvidia }}
  nvidia.com/gpu: {{ include "deepseek.nvidia.gpu" .Values.model.tag }}
  {{- end }}
{{- end }}
{{- end }}

{{/* CPU Configuration Block */}}
{{- define "deepseek.request.cpu" -}}
{{- if eq . "1.5b" }}2
{{- else if eq . "3b" }}3
{{- else if eq . "7b" }}4
{{- else if eq . "8b" }}5
{{- else if eq . "14b" }}8
{{- else if eq . "32b" }}12
{{- else if eq . "70b" }}24
{{- else if eq . "671b" }}64
{{- end }}
{{- end }}

{{/* Memory Configuration Block */}}
{{- define "deepseek.request.memory" -}}
{{- if eq . "1.5b" }}8Gi
{{- else if eq . "3b" }}12Gi
{{- else if eq . "7b" }}16Gi
{{- else if eq . "8b" }}20Gi
{{- else if eq . "14b" }}32Gi
{{- else if eq . "32b" }}64Gi
{{- else if eq . "70b" }}128Gi
{{- else if eq . "671b" }}512Gi
{{- end }}
{{- end }}

{{/* GPU Configuration Block */}}
{{- define "deepseek.amd.gpu" -}}
{{- if eq . "1.5b" }}1
{{- else if eq . "3b" }}1
{{- else if eq . "7b" }}1
{{- else if eq . "8b" }}1
{{- else if eq . "14b" }}1
{{- else if eq . "32b" }}4
{{- else if eq . "70b" }}8
{{- else if eq . "671b" }}16
{{- end }}
{{- end }}

{{- define "deepseek.nvidia.gpu" -}}
{{- if eq . "1.5b" }}1
{{- else if eq . "3b" }}1
{{- else if eq . "7b" }}1
{{- else if eq . "8b" }}1
{{- else if eq . "14b" }}1
{{- else if eq . "32b" }}2
{{- else if eq . "70b" }}4
{{- else if eq . "671b" }}8
{{- end }}
{{- end }}

{{- define "deepseek.limit.cpu" -}}
{{- if eq . "1.5b" }}4
{{- else if eq . "3b" }}5
{{- else if eq . "7b" }}6
{{- else if eq . "8b" }}7
{{- else if eq . "14b" }}10
{{- else if eq . "32b" }}14
{{- else if eq . "70b" }}26
{{- else if eq . "671b" }}68
{{- end }}
{{- end }}

{{- define "deepseek.limit.memory" -}}
{{- if eq . "1.5b" }}10Gi
{{- else if eq . "3b" }}15Gi
{{- else if eq . "7b" }}20Gi
{{- else if eq . "8b" }}25Gi
{{- else if eq . "14b" }}40Gi
{{- else if eq . "32b" }}80Gi
{{- else if eq . "70b" }}160Gi
{{- else if eq . "671b" }}720Gi
{{- end }}
{{- end }}