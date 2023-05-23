apiVersion: argoproj.io/v1alpha1
kind: ApplicationSet
metadata:
  name: minio-loki-tenant
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
      name: "{{name}}-minio-loki-tenant"
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
          path: "./storage/minio-tenant"
          helm:
            releaseName: "minio-loki" # Release name override (defaults to application name)
            valueFiles:
              - "values.yaml"
              - "$valuesRepo/cluster/{{name}}/storage/minio-loki-tenant/values.yaml"
      destination:
        name: "{{name}}"
        namespace: "minio-loki"
      syncPolicy:
        automated:
          prune: false
          selfHeal: true
        syncOptions:
          - CreateNamespace=true
        retry:
          limit: 5
{% endraw %}