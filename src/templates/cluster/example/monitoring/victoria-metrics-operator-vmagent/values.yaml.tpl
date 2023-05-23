agent:
  remoteWriteUrl: http://victoria-metrics-cluster-vminsert.victoria-metrics:8480/insert/0/prometheus
ingress:
  enabled: {{ cluster.service_catalog.monitoring.victoriaMetrics.vmagent.enabled | lower }}
  className: nginx
  issuer: {{ cluster.defaults.clusterIssuerDNS }}
  host: {{ cluster.service_catalog.monitoring.victoriaMetrics.vmagent.host }}