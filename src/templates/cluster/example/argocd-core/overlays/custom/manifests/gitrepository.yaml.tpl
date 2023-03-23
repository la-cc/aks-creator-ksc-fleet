apiVersion: v1
kind: Secret
metadata:
  name: application
  namespace: argocd
  labels:
    argocd.argoproj.io/secret-type: repository
stringData:
  url: {{ cluster.service_catalog.argocd_core.git_repository_URL }}
{% if cluster.service_catalog.argocd_core.git_repository_private %}
  password: {{ cluster.service_catalog.argocd_core.git_repository_PAT}}
  username: {{ cluster.service_catalog.argocd_core.git_repository_user }}
{% endif %}
  insecure: "false" # Ignore validity of server's TLS certificate. Defaults to "false"
  forceHttpBasicAuth: "true" # Skip auth method negotiation and force usage of HTTP basic auth. Defaults to "false"
  enableLfs: "true" # Enable git-lfs for this repository. Defaults to "false"
