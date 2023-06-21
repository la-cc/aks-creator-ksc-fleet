{% if cluster.service_catalog.argocd_core.additional_stage is defined %}
apiVersion: argoproj.io/v1alpha1
kind: Application
metadata:
  name: application-initializer-{{ cluster.service_catalog.argocd_core.additional_stage.stage_name }}
  namespace: argocd
spec:
  destination:
    namespace: argocd
    server: https://kubernetes.default.svc
  project: default
  revisionHistoryLimit: 10
  source:
    directory:
      recurse: true
    path: applicationset/env/{{ cluster.service_catalog.argocd_core.additional_stage.stage_name }}
    repoURL: {{ cluster.service_catalog.argocd_core.additional_stage.app_repository_URL }}
    targetRevision: main
  syncPolicy:
    automated:
      allowEmpty: false
      prune: false
      selfHeal: true
    retry:
      backoff:
        duration: 5s
        factor: 2
        maxDuration: 3m
      limit: 5
    syncOptions:
      - Validate=false
      - CreateNamespace=true
      - PrunePropagationPolicy=foreground
      - PruneLast=true
{% endif %}