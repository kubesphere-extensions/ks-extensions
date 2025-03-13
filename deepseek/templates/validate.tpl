{{- if or 
    (and .Values.ollama.enabled (index .Values "ipex-llm" "enabled"))
    (and (not .Values.ollama.enabled) (not  (index .Values "ipex-llm" "enabled")))
  -}}
{{- fail "Error: Must enable exactly ONE of [ollama, ipex-llm]" -}}
{{- end -}}