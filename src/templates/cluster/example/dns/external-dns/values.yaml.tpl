{% if cluster.service_catalog.externalDNS.enabled %}
pdns_api_key: ""

external-dns:
  provider: azure
  azure:
    resourceGroup: {{ cluster.service_catalog.externalDNS.resource_group }}
    tenantId: {{ cluster.service_catalog.externalDNS.tenantID }}
    subscriptionId: {{ cluster.global.subscriptionID }}
    useManagedIdentityExtension: true
    userAssignedIdentityID: {{ cluster.global.kubeletManagedIdentity }}
  domainFilters:
  {%- for filter in cluster.service_catalog.externalDNS.domain_filters %}
    - {{ filter }}
  {%- endfor %}
  txtOwnerId: {{ cluster.service_catalog.externalDNS.txtOwnerId }}
{% endif %}
