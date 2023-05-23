alertmanager:
  ingress:
    enabled: false
    className: "nginx"
    annotations:
        kubernetes.io/ingress.class: nginx
        kubernetes.io/tls-acme: "true"
        cert-manager.io/cluster-issuer: {{ cluster.defaults.clusterIssuerDNS }}
        cert-manager.io/renew-before: 360h
    hosts:
      - host: {{ cluster.service_catalog.monitoring.prometheusalertmanager.hostname }}
        paths:
          - path: /
            pathType: ImplementationSpecific
    tls:
      - secretName: {{ cluster.service_catalog.monitoring.prometheusalertmanager.hostname }}
        hosts:
            - {{ cluster.service_catalog.monitoring.prometheusalertmanager.hostname }}

  persistence:
    enabled: true
    storageClass: {{ cluster.defaults.storageClass }}

  configmapReload:
    enabled: true
    name: configmap-reload
