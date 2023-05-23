metrics:
  tenantName: {{ cluster.service_catalog.monitoring.minio.tenant.name }}

tenant:
  ## Secret with default environment variable configurations to be used by MinIO Tenant.
  ## Not recommended for production deployments! Create the secret manually instead.
  secrets:
    name: {{ cluster.service_catalog.monitoring.minio.userConfiguration.name }}
    # MinIO root user and password
    accessKey: {{ cluster.service_catalog.monitoring.minio.userConfiguration.accessKey }}
    secretKey: {{ cluster.service_catalog.monitoring.minio.userConfiguration.secretKey }}
  ## MinIO Tenant Definition
  tenant:
    # Tenant name
    name: {{ cluster.service_catalog.monitoring.minio.tenant.name }}
    configuration:
      name: {{ cluster.service_catalog.monitoring.minio.userConfiguration.name }}
    ## Specification for MinIO Pool(s) in this Tenant.
    pools:
      {%- for pool in cluster.service_catalog.monitoring.minio.tenant.pools %}
      - servers: {{ pool.servers }}
        ## custom name for the pool
        name: {{ pool.name }}
        ## volumesPerServer specifies the number of volumes attached per MinIO Tenant Pod / Server.
        volumesPerServer: {{ pool.volumesPerServer }}
        ## size specifies the capacity per volume
        size: {{ pool.size }}Gi
        ## storageClass specifies the storage class name to be used for this pool
        storageClassName: {{ cluster.defaults.storageClass }}
      {%- endfor %}
    ## List of bucket names to create during tenant provisioning
    buckets:
      {%- for bucket in cluster.service_catalog.monitoring.minio.tenant.buckets %}
        - name: {{ bucket.name }}
          objectLock: {{ bucket.objectLock }}
          region: {{ bucket.region }}
      {%- endfor %}
    # kubernetes service account associated with a specific tenant
    # https://kubernetes.io/docs/tasks/configure-pod-container/configure-service-account/
    serviceAccountName: {{ cluster.service_catalog.monitoring.minio.tenant.serviceAccountName }}

  env:
    - name: MINIO_PROMETHEUS_AUTH_TYPE
      value: public

  ingress:
    api:
      enabled: {{ cluster.service_catalog.monitoring.minio.tenant.ingress.api.enabled }}
      tls:
        - {{ cluster.service_catalog.monitoring.minio.tenant.ingress.api.host }}
      host: {{ cluster.service_catalog.monitoring.minio.tenant.ingress.api.host }}
    console:
      enabled: {{ cluster.service_catalog.monitoring.minio.tenant.ingress.console.enabled }}
      tls:
        - {{ cluster.service_catalog.monitoring.minio.tenant.ingress.console.host }}
      host: {{ cluster.service_catalog.monitoring.minio.tenant.ingress.console.host }}