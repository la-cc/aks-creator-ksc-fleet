{% if cluster.service_catalog.externalDNS.enable %}
external-dns:
  provider: azure
  azure:
    resourceGroup: {{ cluster.service_catalog.externalDNS.resource_group }}
    tenantId: {{ cluster.service_catalog.externalDNS.tenantID }}
    subscriptionId: {{ cluster.service_catalog.externalDNS.subscriptionID }}
    useManagedIdentityExtension: true
  domainFilters:
  {%- for filter in cluster.service_catalog.externalDNS.domain_filters %}
    - {{ filter }}
  {%- endfor %}
  txtOwnerId: {{ cluster.service_catalog.externalDNS.txtOwnerId }}
{% endif %}
