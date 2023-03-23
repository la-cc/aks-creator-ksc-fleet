apiVersion: argoproj.io/v1alpha1
kind: ApplicationSet
metadata:
  name: cert-manager
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
      name: "{{name}}-cert-manager"
      annotations:
        argocd.argoproj.io/manifest-generate-paths: ".;.."
{% endraw %}
    spec:
      project: bootstrap
      source:
        repoURL: {{ ksc.repoURL }}
        targetRevision: main
{% raw %}
        path: "./helm/security/cert-manager"
        helm:
          releaseName: "cert-manager" # Release name override (defaults to application name)
          valueFiles:
            - "values.yaml"
      destination:
        name: "{{name}}"
        namespace: "cert-manager"
      syncPolicy:
        automated:
          prune: false
          selfHeal: true
        syncOptions:
          - CreateNamespace=true
        retry:
          limit: 5
      ignoreDifferences:
        - group: admissionregistration.k8s.io
          kind: ValidatingWebhookConfiguration
          name: cert-manager-webhook
          jqPathExpressions:
            - .webhooks[].namespaceSelector.matchExpressions[] | select(.key == "control-plane")
{% endraw %}
