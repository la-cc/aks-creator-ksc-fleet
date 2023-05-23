apiVersion: kustomize.config.k8s.io/v1beta1
kind: Kustomization

resources:
{% if cluster.service_catalog.security.clusterIssuerDNS.enabled %}
  - cluster-issuer-dns.yaml
{% endif %}
{% if cluster.service_catalog.security.clusterIssuerHTTP.enabled %}
  - cluster-issuer-http.yaml
{% endif %}

