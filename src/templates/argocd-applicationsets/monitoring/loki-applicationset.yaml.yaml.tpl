apiVersion: argoproj.io/v1alpha1
kind: ApplicationSet
metadata:
  name: loki
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
      name: "{{name}}-grafana-loki"
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
          path: "./monitoring/grafana-loki"
          helm:
            releaseName: "loki"
            valueFiles:
              - "values.yaml"
              - "$valuesRepo/cluster/{{name}}/monitoring/grafana-loki/values.yaml"
      destination:
        name: "{{name}}"
        namespace: "loki"
      syncPolicy:
        automated:
          prune: false
          selfHeal: true
        syncOptions:
          - CreateNamespace=true
          - RespectIgnoreDifferences=true
        retry:
          limit: 10
      ignoreDifferences:
        - group: apps
          kind: StatefulSet
          name: loki-write
          jsonPointers:
            - /spec/persistentVolumeClaimRetentionPolicy/whenDeleted
            - /spec/persistentVolumeClaimRetentionPolicy/whenScaled
            - /spec/persistentVolumeClaimRetentionPolicy
        - group: apps
          kind: StatefulSet
          name: loki-read
          jsonPointers:
            - /spec/persistentVolumeClaimRetentionPolicy/whenDeleted
            - /spec/persistentVolumeClaimRetentionPolicy/whenScaled
            - /spec/persistentVolumeClaimRetentionPolicy
{% endraw %}