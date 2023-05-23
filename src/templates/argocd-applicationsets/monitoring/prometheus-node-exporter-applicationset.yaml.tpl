apiVersion: argoproj.io/v1alpha1
kind: ApplicationSet
metadata:
  name: prometheus-node-exporter
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
      name: "{{name}}-prometheus-node-exporter"
      annotations:
        argocd.argoproj.io/manifest-generate-paths: ".;.."
    spec:
      project: default
      sources:
        - repoURL: https://github.com/Hamburg-Port-Authority/kubernetes-service-catalog.git
          targetRevision: '{{values.branch}}'
          path: "./monitoring/prometheus-node-exporter"
          helm:
            releaseName: "prometheus-node-exporter" # Release name override (defaults to application name)
            valueFiles:
              - "values.yaml"
      destination:
        name: "{{name}}"
        namespace: "victoria-metrics"
      syncPolicy:
        automated:
          prune: false
          selfHeal: true
        syncOptions:
          - CreateNamespace=true
        retry:
          limit: 5
{% endraw %}