operator:
  # Default values for minio-operator.
  operator:
    env:
      - name: MINIO_PROMETHEUS_AUTH_TYPE
        value: public
    replicaCount: {{ cluster.service_catalog.minio_operator.operatorReplicaCount }}
  console:
    replicaCount: {{ cluster.service_catalog.minio_operator.consoleReplicaCount }}
    ingress:
      enabled: {{ cluster.service_catalog.minio_operator.ingress.enabled | lower }}
      annotations:
        nginx.ingress.kubernetes.io/force-ssl-redirect: "true"
        cert-manager.io/cluster-issuer: "{{ cluster.service_catalog.minio_operator.ingress.annotationClusterIssuer }}"
        cert-manager.io/common-name: "{{ cluster.service_catalog.minio_operator.ingress.hostname }}"
      host: "{{ cluster.service_catalog.minio_operator.ingress.hostname }}"
