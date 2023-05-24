apiVersion: external-secrets.io/v1alpha1
kind: SecretStore
metadata:
  name: {{ cluster.service_catalog.security.externalSecrets.secretStoreName }}
spec:
  provider:
    # provider type: azure keyvault
    azurekv:
      authType: ManagedIdentity
      # Optionally set the Id of the Managed Identity, if multiple identities are assigned to external-secrets operator
      identityId: {{ cluster.service_catalog.security.externalSecrets.identityId }}
      # URL of your vault instance, see: https://docs.microsoft.com/en-us/azure/key-vault/general/about-keys-secrets-certificates
      vaultUrl: {{ cluster.service_catalog.security.externalSecrets.vaultUrl }}
