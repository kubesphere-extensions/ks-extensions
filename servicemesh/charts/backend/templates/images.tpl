{{- define "common.images.image" -}}
{{- $registryName := .global.imageRegistry -}}
{{- $repositoryName := .imageRoot.repository -}}
{{- $separator := ":" -}}
{{- $termination := .global.imageTag | toString -}}
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
Return the proper kubectl image name
*/}}
{{- define "kubectl.image" -}}
{{ include "common.images.image" (dict "imageRoot" .Values.kubectl.image "global" .Values.global) }}
{{- end -}}


{{/*
Return the proper jaeger operator image name
*/}}
{{- define "jaeger.operator.image" -}}
{{ include "common.images.image" (dict "imageRoot" .Values.jaeger.image.operator "global" .Values.global) }}
{{- end -}}

{{/*
Return the proper jaeger agent image name
*/}}
{{- define "jaeger.agent.image" -}}
{{ include "common.images.image" (dict "imageRoot" .Values.jaeger.image.agent "global" .Values.global) }}
{{- end -}}

{{/*
Return the proper jaeger collector image name
*/}}
{{- define "jaeger.collector.image" -}}
{{ include "common.images.image" (dict "imageRoot" .Values.jaeger.image.collector "global" .Values.global) }}
{{- end -}}

{{/*
Return the proper jaeger query image name
*/}}
{{- define "jaeger.query.image" -}}
{{ include "common.images.image" (dict "imageRoot" .Values.jaeger.image.query "global" .Values.global) }}
{{- end -}}

{{/*
Return the proper jaeger es-index-cleaner image name
*/}}
{{- define "jaeger.es-index-cleaner.image" -}}
{{ include "common.images.image" (dict "imageRoot" .Values.jaeger.image.esIndexCleaner "global" .Values.global) }}
{{- end -}}

{{/*
Return the proper kiali image name
*/}}
{{- define "kiali.image" -}}
{{ include "common.images.image" (dict "imageRoot" .Values.kiali.image "global" .Values.global) }}
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

{{/*
Return the proper istioctl image name
*/}}
{{- define "istioctl.image" -}}
{{ include "common.images.image" (dict "imageRoot" .Values.istioctl.image "global" .Values.global) }}
{{- end -}}

{{/*
Return the istio install config
*/}}
{{- define "istio-config" -}}
apiVersion: install.istio.io/v1alpha1
kind: IstioOperator
spec:
  hub: {{ $.Values.global.imageRegistry }}/istio

  components:
    base:
      enabled: true
    pilot:
      enabled: true
    ingressGateways:
    - name: istio-ingressgateway
      enabled: false
  values:
    {{- toYaml $.Values.istio | nindent 4 }}
{{- end -}}
