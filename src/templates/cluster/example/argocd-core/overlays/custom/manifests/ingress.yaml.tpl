apiVersion: networking.k8s.io/v1
kind: Ingress
metadata:
  name: argocd-server-ingress
  annotations:
    kubernetes.io/ingress.class: nginx
    ingress.kubernetes.io/force-ssl-redirect: "true"
    nginx.ingress.kubernetes.io/ssl-passthrough: "true"
    cert-manager.io/cluster-issuer: {{ cluster.service_catalog.argocd_core.ingress.issuer }}
    cert-manager.io/common-name: {{ cluster.service_catalog.argocd_core.ingress.hostname }}
    kubernetes.io/tls-acme: "true"
    nginx.ingress.kubernetes.io/backend-protocol: "HTTPS"
spec:
  rules:
    - host: {{ cluster.service_catalog.argocd_core.ingress.hostname }}
      http:
        paths:
          - path: /
            pathType: Prefix
            backend:
              service:
                name: argocd-server
                port:
                  name: https
  tls:
    - hosts:
        - {{ cluster.service_catalog.argocd_core.ingress.hostname }}
      secretName: argocd-secret # do not change, this is provided by Argo CD
