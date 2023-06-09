apiVersion: argoproj.io/v1alpha1
kind: ApplicationSet
metadata:
  name: promtail
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
      name: "{{name}}-grafana-promtail"
      annotations:
        argocd.argoproj.io/manifest-generate-paths: ".;.."
    spec:
      project: default
      sources:
        - repoURL: https://github.com/Hamburg-Port-Authority/kubernetes-service-catalog.git
          targetRevision: '{{values.branch}}'
          path: "./monitoring/grafana-promtail"
          helm:
            releaseName: "promtail"
            valueFiles:
              - "values.yaml"
      destination:
        name: "{{name}}"
        namespace: "loki"
      syncPolicy:
        automated:
          prune: false
          selfHeal: true
        syncOptions:
          - CreateNamespace=true
        retry:
          limit: 10
{% endraw %}