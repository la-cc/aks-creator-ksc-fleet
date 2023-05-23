ingress:
  enabled: false
  host: {{ cluster.service_catalog.mail.ingress.hostname }}
  certificateIssuer: {{ cluster.defaults.clusterIssuerDNS }}
  className: nginx