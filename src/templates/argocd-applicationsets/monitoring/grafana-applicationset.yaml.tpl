apiVersion: argoproj.io/v1alpha1
kind: ApplicationSet
metadata:
  name: grafana
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
      name: "{{name}}-grafana"
      annotations:
        argocd.argoproj.io/manifest-generate-paths: ".;.."
{% endraw %}
    spec:
      project: default
      sources:
        - repoURL: {{ ksc.repoURL }}
          targetRevision: main
          ref: valuesRepo
 {% raw %}
        - repoURL: https://github.com/Hamburg-Port-Authority/kubernetes-service-catalog.git
          targetRevision: '{{values.branch}}'
          path: "./monitoring/grafana"
          helm:
            releaseName: "grafana" # Release name override (defaults to application name)
            valueFiles:
              - "values.yaml"
              - "$valuesRepo/cluster/{{name}}/monitoring/grafana/values.yaml"
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