grafana:
  adminUser: {{ cluster.service_catalog.monitoring.grafana.adminUser }}
  adminPassword: {{ cluster.service_catalog.monitoring.grafana.adminPassword }}
  ingress:
    annotations:
      nginx.ingress.kubernetes.io/force-ssl-redirect: "true"
      cert-manager.io/cluster-issuer: {{ cluster.defaults.clusterIssuerDNS }}
      cert-manager.io/renew-before: 360h #15 days
      cert-manager.io/common-name: {{ cluster.service_catalog.monitoring.grafana.hostname }}
    hosts:
      - {{ cluster.service_catalog.monitoring.grafana.hostname }}
    tls:
      - secretName: {{ cluster.service_catalog.monitoring.grafana.hostname }}
        hosts:
          - {{ cluster.service_catalog.monitoring.grafana.hostname }}
  env:
    GF_AUTH_AZUREAD_CLIENT_SECRET: {{ cluster.service_catalog.monitoring.grafana.azure.clientsecret }}

  testFramework:
    enabled: true

  grafana.ini:
    server:
      root_url: https://{{ cluster.service_catalog.monitoring.grafana.hostname }}
    auth.azuread:
      enabled: true
      allow_sign_up: true
      scopes: openid email profile
      client_id: {{ cluster.service_catalog.monitoring.grafana.azure.clientid }}
      auth_url: {{ cluster.service_catalog.monitoring.grafana.azure.authurl }}
      token_url: {{ cluster.service_catalog.monitoring.grafana.azure.tokenurl }}
      allowed_groups: {{ cluster.service_catalog.monitoring.grafana.azure.allowedgroups }}