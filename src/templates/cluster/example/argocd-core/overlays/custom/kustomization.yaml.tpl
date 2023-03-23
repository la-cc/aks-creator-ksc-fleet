apiVersion: kustomize.config.k8s.io/v1beta1
kind: Kustomization

bases:
  - ../../../../../kustomize/argocd-core/base/

resources:
  - "manifests/gitrepository.yaml"
  - "manifests/application-initializer.yaml"
{% if cluster.service_catalog.argocd_core.ingress.enable %}
  - "manifests/ingress.yaml"
{% endif %}
