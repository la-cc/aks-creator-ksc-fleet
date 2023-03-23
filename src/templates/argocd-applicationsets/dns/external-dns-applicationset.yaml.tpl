apiVersion: argoproj.io/v1alpha1
kind: ApplicationSet
metadata:
  name: external-dns
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
      name: "{{name}}-external-dns"
      annotations:
        argocd.argoproj.io/manifest-generate-paths: ".;.."
{% endraw %}
    spec:
      project: bootstrap
      source:
        repoURL: {{ ksc.repoURL }}
        targetRevision: main
{% raw %}
        path: "./helm/dns/external-dns"
        helm:
          releaseName: "external-dns" # Release name override (defaults to application name)
          valueFiles:
            - "values.yaml"
            - "../../../cluster/{{name}}/dns/external-dns/values.yaml"
      destination:
        name: "{{name}}"
        namespace: "external-dns"
      syncPolicy:
        automated:
          prune: false
          selfHeal: true
        syncOptions:
          - CreateNamespace=true
        retry:
          limit: 5
{% endraw %}
