init:
  application:
  {%- for init in cluster.service_catalog.argocd_core.initializer %}
    - repository: {{ init.git_repository_URL }}
      applicationEnabled: {{ init.application_enabled | lower }}
      path: "{{ init.git_repository_path }}"
      targetRevision: {{ init.targetRevision }}
      manifestId: {{ init.manifestId }}
  {% endfor %}
  repository:
  {%- for init in cluster.service_catalog.argocd_core.initializer %}
    - repositoryEnabled: {{ init.git_repository_enabled | lower }}
      url: "{{ init.git_repository_URL }}"
      manifestId: {{ init.manifestId }}
      #private == username + pw or ssh-key are needed
    {% if init.git_repository_private %}
      username: "{{ init.git_repository_user }}"
      password: "{{ init.git_repository_PAT}}"
      insecure: "false"
      forceHttpBasicAuth: "true"
    {% endif %}
  {% endfor %}
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
