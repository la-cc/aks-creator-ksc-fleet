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
            env: dev
    - clusters:
        selector:
          matchLabels:
            env: prod
{% raw %}
  template:
    metadata:
      name: "{{name}}-argocd-core"
      annotations:
        argocd.argoproj.io/manifest-generate-paths: ".;.."
{% endraw %}
    spec:
      project: bootstrap
      source:
        repoURL: {{ ksc.repoURL }}
        targetRevision: main
{% raw %}
        path: "./cluster/{{name}}/argocd-core/overlays/custom"
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
