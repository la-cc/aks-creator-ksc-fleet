apiVersion: argoproj.io/v1alpha1
kind: ApplicationSet
metadata:
  name: cluster-issuer
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
      name: "{{name}}-cluster-issuer"
      annotations:
        argocd.argoproj.io/manifest-generate-paths: ".;.."
{% endraw %}
    spec:
      project: bootstrap
      source:
        repoURL: {{ ksc.repoURL }}
        targetRevision: main
{% raw %}
        path: "./cluster/{{name}}/security/cluster-issuer"
      destination:
        name: "{{name}}"
        namespace: "default"
      syncPolicy:
        automated:
          prune: false
          selfHeal: true
        syncOptions:
          - CreateNamespace=false
        retry:
          limit: 5
{% endraw %}
