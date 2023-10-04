loki:
  global:
  loki:
    storage:
      s3:
        secretAccessKey: {{ cluster.service_catalog.monitoring.minio.userConfiguration.secretKey }}
        accessKeyId: {{ cluster.service_catalog.monitoring.minio.userConfiguration.accessKey }}
  write:
    replicas: {{ cluster.service_catalog.monitoring.loki.write.replicaCount }}
    persistence:
      enableStatefulSetAutoDeletePVC: {{ cluster.service_catalog.monitoring.loki.write.persistence.autoDeletePVC }}
      size: {{ cluster.service_catalog.monitoring.loki.read.persistence.size }}Gi
      storageClass: {{ cluster.defaults.storageClass }}
  # Configuration for the read pod(s)
  read:
    replicas: {{ cluster.service_catalog.monitoring.loki.read.replicaCount }}
    persistence:
      enableStatefulSetAutoDeletePVC: {{ cluster.service_catalog.monitoring.loki.read.persistence.autoDeletePVC }}
      size: {{ cluster.service_catalog.monitoring.loki.read.persistence.size }}Gi
      storageClass: {{ cluster.defaults.storageClass }}
  # Configuration for the backend pod(s)
  backend:
    replicas: {{ cluster.service_catalog.monitoring.loki.backend.replicaCount }}
    persistence:
      enableStatefulSetAutoDeletePVC: {{ cluster.service_catalog.monitoring.loki.backend.persistence.autoDeletePVC }}
      size: {{ cluster.service_catalog.monitoring.loki.read.persistence.size }}Gi
      storageClass: {{ cluster.defaults.storageClass }}
  rbac:
    pspEnabled: false