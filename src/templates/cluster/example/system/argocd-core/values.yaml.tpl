init:
  application:
    enabled: {{ cluster.service_catalog.argocd_core.application_enabled | lower }}
    path: "{{ cluster.service_catalog.argocd_core.git_repository_path }}"
    targetRevision: "main"
  repository:
    enabled: {{ cluster.service_catalog.argocd_core.git_repository_enabled | lower }}
    url: "{{ cluster.service_catalog.argocd_core.git_repository_URL }}"
    #private == username + pw or ssh-key are needed
  {% if cluster.service_catalog.argocd_core.git_repository_private %}
    username: "{{ cluster.service_catalog.argocd_core.git_repository_user }}"
    password: "{{ cluster.service_catalog.argocd_core.git_repository_PAT}}"
  {% endif %}
    insecure: "false"
    forceHttpBasicAuth: "true"
  externalSecret:
    enabled: {{ cluster.service_catalog.argocd_core.external_secret_enabled | lower }}

ingress:
  enabled: "true"
  host: "{{ cluster.service_catalog.argocd_core.ingress.hostname }}"
  issuer: "{{ cluster.service_catalog.argocd_core.ingress.issuer }}"
  className: "nginx"

argo-cd:
  global:
    revisionHistoryLimit: 2
  dex:
    enabled: false
  server:
    replicas: 1
    ## Argo CD server Horizontal Pod Autoscaler
    autoscaling:
      # -- enabled Horizontal Pod Autoscaler ([HPA]) for the Argo CD server
      enabled: false
      # -- Minimum number of replicas for the Argo CD server [HPA]
      minReplicas: 1
      # -- Maximum number of replicas for the Argo CD server [HPA]
      maxReplicas: 5

  repoServer:
    replicas: 1
    ## Repo server Horizontal Pod Autoscaler
    autoscaling:
      # -- enabled Horizontal Pod Autoscaler ([HPA]) for the repo server
      enabled: false
      # -- Minimum number of replicas for the repo server [HPA]
      minReplicas: 1
      # -- Maximum number of replicas for the repo server [HPA]
      maxReplicas: 5
  applicationSet:
    replicaCount: 1
