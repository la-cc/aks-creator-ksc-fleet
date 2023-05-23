apiVersion: argoproj.io/v1alpha1
kind: ApplicationSet
metadata:
  name: argocd-core
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
      name: "{{name}}-argocd-core"
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
          path: "./system/argocdcore"
          helm:
            releaseName: "argocd-core" # Release name override (defaults to application name)
            valueFiles:
              - "values.yaml"
              - "$valuesRepo/cluster/{{name}}/system/argocd-core/values.yaml"
      destination:
        name: "{{name}}"
        namespace: "argocd"
      syncPolicy:
        automated:
          prune: false
          selfHeal: true
        syncOptions:
          - CreateNamespace=true
        retry:
          limit: 5
{% endraw %}
