apiVersion: argoproj.io/v1alpha1
kind: ApplicationSet
metadata:
  name: sealed-secrets
  namespace: argocd
spec:
  generators:
    - clusters:
        selector:
          matchLabels:
            env: dev
    - clusters:
        selector:
          matchLabels:
            env: prod
{% raw %}
  template:
    metadata:
      name: "{{name}}-sealed-secrets"
      annotations:
        argocd.argoproj.io/manifest-generate-paths: ".;.."
{% endraw %}
    spec:
      project: bootstrap
      source:
        repoURL: {{ ksc.repoURL }}
        targetRevision: main
{% raw %}
        path: "./helm/security/sealed-secrets"
        helm:
          releaseName: "sealed-secrets" # Release name override (defaults to application name)
          valueFiles:
            - "values.yaml"
            - "../../../cluster/{{name}}/security/sealed-secrets/values.yaml"
      destination:
        name: "{{name}}"
        namespace: "sealed-secrets"
      syncPolicy:
        automated:
          prune: false
          selfHeal: true
        syncOptions:
          - CreateNamespace=true
        retry:
          limit: 5
{% endraw %}