ingress-nginx:
  controller:
    service:
      annotations:
        service.beta.kubernetes.io/azure-load-balancer-health-probe-request-path: /healthz
