apiVersion: argoproj.io/v1alpha1
kind: ApplicationSet
metadata:
  name: nginx-ingress
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
      name: "{{name}}-nginx-ingress"
      annotations:
        argocd.argoproj.io/manifest-generate-paths: ".;.."
{% endraw %}
    spec:
      project: bootstrap
      source:
        repoURL: {{ ksc.repoURL }}
        targetRevision: main
{% raw %}
        path: "./helm/networking/ingress-nginx"
        helm:
          releaseName: "ingress-nginx" # Release name override (defaults to application name)
          valueFiles:
            - "values.yaml"
      destination:
        name: "{{name}}"
        namespace: "nginx-ingress"
      syncPolicy:
        automated:
          prune: false
          selfHeal: true
        syncOptions:
          - CreateNamespace=true
        retry:
          limit: 5
{% endraw %}