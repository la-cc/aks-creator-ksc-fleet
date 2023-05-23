apiVersion: cert-manager.io/v1
kind: ClusterIssuer
metadata:
  name: {{ cluster.defaults.clusterIssuerDNS }}
spec:
  acme:
    server: https://acme-v02.api.letsencrypt.org/directory
    email: {{ cluster.service_catalog.security.clusterIssuerDNS.e_mail }}
    privateKeySecretRef:
      name: {{ cluster.defaults.clusterIssuerDNS }}
    solvers:
      - dns01:
          azureDNS:
            subscriptionID: {{ cluster.service_catalog.security.clusterIssuerDNS.subscriptionID }}
            resourceGroupName: {{ cluster.service_catalog.security.clusterIssuerDNS.resourceGroupName }}
            hostedZoneName: {{ cluster.service_catalog.security.clusterIssuerDNS.hostedZoneName }}
            # Azure Cloud Environment, default to AzurePublicCloud
            environment: AzurePublicCloud
            # optional, only required if node pools have more than 1 managed identity assigned
            # managedIdentity:
            # client id of the node pool managed identity (can not be set at the same time as resourceID)
            # clientID: ""
            # resource id of the managed identity (can not be set at the same time as clientID)
            # resourceID: YOUR_MANAGED_IDENTITY_RESOURCE_ID