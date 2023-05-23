ingress:
  enabled: {{ cluster.service_catalog.monitoring.prometheusalertmanager.enabled | lower }}
  host: {{ cluster.service_catalog.monitoring.prometheusalertmanager.hostname }}
  className: nginx
  certificateIssuer: {{ cluster.defaults.clusterIssuerDNS }}