{% raw %}
# Source: victoria-metrics-k8s-stack/templates/rules/kubernetes-resources.yaml
apiVersion: operator.victoriametrics.com/v1beta1
kind: VMRule
metadata:
  name: vmrule-kubernetes-resources
spec:
  groups:
  - name: kubernetes-resources
    rules:
    - alert: KubeCPUOvercommit
      annotations:
        description: Cluster has overcommitted CPU resource requests for Pods by {{ $value }} CPU shares and cannot tolerate node failure.
        runbook_url: https://runbooks.prometheus-operator.dev/runbooks/kubernetes/kubecpuovercommit
        summary: Cluster has overcommitted CPU resource requests.
      expr: |-
        sum(namespace_cpu:kube_pod_container_resource_requests:sum{}) - (sum(kube_node_status_allocatable{resource="cpu"}) - max(kube_node_status_allocatable{resource="cpu"})) > 0
        and
        (sum(kube_node_status_allocatable{resource="cpu"}) - max(kube_node_status_allocatable{resource="cpu"})) > 0
      for: 10m
      labels:
        severity: warning
    - alert: KubeMemoryOvercommit
      annotations:
        description: Cluster has overcommitted memory resource requests for Pods by {{ $value | humanize }} bytes and cannot tolerate node failure.
        runbook_url: https://runbooks.prometheus-operator.dev/runbooks/kubernetes/kubememoryovercommit
        summary: Cluster has overcommitted memory resource requests.
      expr: |-
        sum(namespace_memory:kube_pod_container_resource_requests:sum{}) - (sum(kube_node_status_allocatable{resource="memory"}) - max(kube_node_status_allocatable{resource="memory"})) > 0
        and
        (sum(kube_node_status_allocatable{resource="memory"}) - max(kube_node_status_allocatable{resource="memory"})) > 0
      for: 10m
      labels:
        severity: warning
    - alert: KubeCPUQuotaOvercommit
      annotations:
        description: Cluster has overcommitted CPU resource requests for Namespaces.
        runbook_url: https://runbooks.prometheus-operator.dev/runbooks/kubernetes/kubecpuquotaovercommit
        summary: Cluster has overcommitted CPU resource requests.
      expr: |-
        sum(min without(resource) (kube_resourcequota{job="kube-state-metrics", type="hard", resource=~"(cpu|requests.cpu)"}))
          /
        sum(kube_node_status_allocatable{resource="cpu", job="kube-state-metrics"})
          > 1.5
      for: 5m
      labels:
        severity: warning
    - alert: KubeMemoryQuotaOvercommit
      annotations:
        description: Cluster has overcommitted memory resource requests for Namespaces.
        runbook_url: https://runbooks.prometheus-operator.dev/runbooks/kubernetes/kubememoryquotaovercommit
        summary: Cluster has overcommitted memory resource requests.
      expr: |-
        sum(min without(resource) (kube_resourcequota{job="kube-state-metrics", type="hard", resource=~"(memory|requests.memory)"}))
          /
        sum(kube_node_status_allocatable{resource="memory", job="kube-state-metrics"})
          > 1.5
      for: 5m
      labels:
        severity: warning
    - alert: KubeQuotaAlmostFull
      annotations:
        description: Namespace {{ $labels.namespace }} is using {{ $value | humanizePercentage }} of its {{ $labels.resource }} quota.
        runbook_url: https://runbooks.prometheus-operator.dev/runbooks/kubernetes/kubequotaalmostfull
        summary: Namespace quota is going to be full.
      expr: |-
        kube_resourcequota{job="kube-state-metrics", type="used"}
          / ignoring(instance, job, type)
        (kube_resourcequota{job="kube-state-metrics", type="hard"} > 0)
          > 0.9 < 1
      for: 15m
      labels:
        severity: info
    - alert: KubeQuotaFullyUsed
      annotations:
        description: Namespace {{ $labels.namespace }} is using {{ $value | humanizePercentage }} of its {{ $labels.resource }} quota.
        runbook_url: https://runbooks.prometheus-operator.dev/runbooks/kubernetes/kubequotafullyused
        summary: Namespace quota is fully used.
      expr: |-
        kube_resourcequota{job="kube-state-metrics", type="used"}
          / ignoring(instance, job, type)
        (kube_resourcequota{job="kube-state-metrics", type="hard"} > 0)
          == 1
      for: 15m
      labels:
        severity: info
    - alert: KubeQuotaExceeded
      annotations:
        description: Namespace {{ $labels.namespace }} is using {{ $value | humanizePercentage }} of its {{ $labels.resource }} quota.
        runbook_url: https://runbooks.prometheus-operator.dev/runbooks/kubernetes/kubequotaexceeded
        summary: Namespace quota has exceeded the limits.
      expr: |-
        kube_resourcequota{job="kube-state-metrics", type="used"}
          / ignoring(instance, job, type)
        (kube_resourcequota{job="kube-state-metrics", type="hard"} > 0)
          > 1
      for: 15m
      labels:
        severity: warning
    - alert: CPUThrottlingHigh
      annotations:
        description: '{{ $value | humanizePercentage }} throttling of CPU in namespace {{ $labels.namespace }} for container {{ $labels.container }} in pod {{ $labels.pod }}.'
        runbook_url: https://runbooks.prometheus-operator.dev/runbooks/kubernetes/cputhrottlinghigh
        summary: Processes experience elevated CPU throttling.
      expr: |-
        sum(increase(container_cpu_cfs_throttled_periods_total{container!="", }[5m])) by (container, pod, namespace)
          /
        sum(increase(container_cpu_cfs_periods_total{}[5m])) by (container, pod, namespace)
          > ( 25 / 100 )
      for: 15m
      labels:
        severity: info
{% endraw %}
