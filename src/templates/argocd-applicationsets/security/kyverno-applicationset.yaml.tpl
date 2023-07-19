apiVersion: argoproj.io/v1alpha1
kind: ApplicationSet
metadata:
  name: kyverno
  namespace: argocd
spec:
  generators:
    - clusters:
        selector:
          matchLabels:
            env: development
        values:
          branch: development
    - clusters:
        selector:
          matchLabels:
            env: production
        values:
          branch: development
{% raw %}
  template:
    metadata:
      name: "{{name}}-kyverno"
      annotations:
        argocd.argoproj.io/manifest-generate-paths: ".;.."
{% endraw %}
    spec:
      project: default
      sources:
        - repoURL: {{ ksc.repoURL }}
{% raw %}
          targetRevision: main
          path: "./cluster/{{name}}/security/kyverno/policies"
        - repoURL: https://github.com/Hamburg-Port-Authority/kubernetes-service-catalog.git
          targetRevision: "{{values.branch}}"
          path: "./security/kyverno"
          helm:
            releaseName: "kyverno"
            valueFiles:
              - "values.yaml"
      destination:
        name: "{{name}}"
        namespace: "kyverno"
      syncPolicy:
        automated:
          prune: false
          selfHeal: true
        syncOptions:
          - CreateNamespace=true
        retry:
          limit: 5
{% endraw %}