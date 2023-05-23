apiVersion: argoproj.io/v1alpha1
kind: ApplicationSet
metadata:
  name: prometheus-operator-crds
  namespace: argocd
spec:
  generators:
    - clusters:
        selector:
          matchLabels:
            env: development
        values:
          branch: main
    - clusters:
        selector:
          matchLabels:
            env: production
        values:
          branch: main
{% raw %}
  template:
    metadata:
      name: "{{name}}-prometheus-operator-crds"
      annotations:
        argocd.argoproj.io/manifest-generate-paths: ".;.."
        argocd.argoproj.io/sync-options: Replace=true
    spec:
      project: default
      source:
        repoURL: https://github.com/Hamburg-Port-Authority/kubernetes-service-catalog.git
        targetRevision: '{{values.branch}}'
        path: "./monitoring/prometheus-operator-crds"
        helm:
          releaseName: "prometheus-operator-crds" # Release name override (defaults to application name)
          valueFiles:
            - "values.yaml"
      destination:
        name: "{{name}}"
        namespace: "default"
      syncPolicy:
        automated:
          prune: false
          selfHeal: true
        syncOptions:
          - CreateNamespace=false
          - PruneLast=true
          - Replace=true
          - PrunePropagationPolicy=foreground
        retry:
          limit: 5
{% endraw %}