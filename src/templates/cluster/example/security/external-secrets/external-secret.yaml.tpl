apiVersion: external-secrets.io/v1beta1
kind: ExternalSecret
metadata:
  name: azure-devops-repo-access
spec:
  refreshInterval: 1h
  secretStoreRef:
    kind: ClusterSecretStore
    name: {{ cluster.service_catalog.security.externalSecrets.clusterSecretStoreName }}
  target:
    name: {{ cluster.service_catalog.security.externalSecrets.clusterSecretStoreName }}
    # optional: specify a template with any additional markup you would like added to the downstream Secret resource.
    # This template will be deep merged without mutating any existing fields. For example: you cannot override metadata.name.
    template:
      metadata:
        labels:
          argocd.argoproj.io/secret-type: repository
  data:
    - secretKey: url
      remoteRef:
        key: url
    - secretKey: sshPrivateKey
      remoteRef:
        key: sshPrivateKey
        decodingStrategy: Base64
