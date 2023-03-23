apiVersion: kustomize.config.k8s.io/v1beta1
kind: Kustomization

resources:
{% if cluster.service_catalog.security.clusterIssuerDNS.enable %}
  - cluster-issuer-dns.yaml
{% endif %}
{% if cluster.service_catalog.security.clusterIssuerHTTP.enable %}
  - cluster-issuer-http.yaml
{% endif %}

