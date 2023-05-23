{% if cluster.service_catalog.sealed_secrets.enabled %}
tls:
  crt: {{ cluster.service_catalog.sealed_secrets.tls.crt }}
  key: {{ cluster.service_catalog.sealed_secrets.tls.key }}
{% endif %}
