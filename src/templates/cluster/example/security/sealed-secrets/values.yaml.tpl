{% if cluster.service_catalog.sealed_secrets.enable %}
tls:
  crt: {{ cluster.service_catalog.sealed_secrets.tls.crt }}
  key: {{ cluster.service_catalog.sealed_secrets.tls.key }}
{% endif %}
