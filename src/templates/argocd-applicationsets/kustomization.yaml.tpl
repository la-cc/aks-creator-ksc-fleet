resources:
  # dns
  - dns/external-dns-applicationset.yaml

  # networking
  - networking/nginx-ingress-applicationset.yaml

  # security
  - security/cert-manager-applicationset.yaml
  - security/sealed-secrets-applicationset.yaml
  - security/cluster-issuer-applicationset.yaml
