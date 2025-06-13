{{/* Generate Ca */}}
{{- define "cert-manager.issuer" }}
{{- if .Values.defaultIssuer.selfSigned.enabled }}
selfSigned: {}
{{- else if .Values.defaultIssuer.CA.enabled }}
ca:
    secretName: default-issuer-secret
{{- end }}
{{- end }}


{{/* Generate Ca secret */}}
{{- define "cert-manager.secret"}}
apiVersion: v1
kind: Secret
metadata:
  name: default-issuer-secret
  namespace: {{ .Release.Namespace }}
data:
  tls.crt: {{ .Values.defaultIssuer.CA.data.tlsCrt }}
  tls.key: {{ .Values.defaultIssuer.CA.data.tlsKey }}
{{- end }}