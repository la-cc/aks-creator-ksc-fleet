{% raw %}
# Source: victoria-metrics-k8s-stack/templates/rules/kube-state-metrics.yaml
apiVersion: operator.victoriametrics.com/v1beta1
kind: VMRule
metadata:
  name: vmrule-kube-state-metrics
spec:
  groups:
  - name: kube-state-metrics
    rules:
    - alert: KubeStateMetricsListErrors
      annotations:
        description: kube-state-metrics is experiencing errors at an elevated rate in list operations. This is likely causing it to not be able to expose metrics about Kubernetes objects correctly or at all.
        runbook_url: https://runbooks.prometheus-operator.dev/runbooks/kube-state-metrics/kubestatemetricslisterrors
        summary: kube-state-metrics is experiencing errors in list operations.
      expr: |-
        (sum(rate(kube_state_metrics_list_total{job="kube-state-metrics",result="error"}[5m]))
          /
        sum(rate(kube_state_metrics_list_total{job="kube-state-metrics"}[5m])))
        > 0.01
      for: 15m
      labels:
        severity: critical
    - alert: KubeStateMetricsWatchErrors
      annotations:
        description: kube-state-metrics is experiencing errors at an elevated rate in watch operations. This is likely causing it to not be able to expose metrics about Kubernetes objects correctly or at all.
        runbook_url: https://runbooks.prometheus-operator.dev/runbooks/kube-state-metrics/kubestatemetricswatcherrors
        summary: kube-state-metrics is experiencing errors in watch operations.
      expr: |-
        (sum(rate(kube_state_metrics_watch_total{job="kube-state-metrics",result="error"}[5m]))
          /
        sum(rate(kube_state_metrics_watch_total{job="kube-state-metrics"}[5m])))
        > 0.01
      for: 15m
      labels:
        severity: critical
    - alert: KubeStateMetricsShardingMismatch
      annotations:
        description: kube-state-metrics pods are running with different --total-shards configuration, some Kubernetes objects may be exposed multiple times or not exposed at all.
        runbook_url: https://runbooks.prometheus-operator.dev/runbooks/kube-state-metrics/kubestatemetricsshardingmismatch
        summary: kube-state-metrics sharding is misconfigured.
      expr: stdvar (kube_state_metrics_total_shards{job="kube-state-metrics"}) != 0
      for: 15m
      labels:
        severity: critical
    - alert: KubeStateMetricsShardsMissing
      annotations:
        description: kube-state-metrics shards are missing, some Kubernetes objects are not being exposed.
        runbook_url: https://runbooks.prometheus-operator.dev/runbooks/kube-state-metrics/kubestatemetricsshardsmissing
        summary: kube-state-metrics shards are missing.
      expr: |-
        2^max(kube_state_metrics_total_shards{job="kube-state-metrics"}) - 1
          -
        sum( 2 ^ max by (shard_ordinal) (kube_state_metrics_shard_ordinal{job="kube-state-metrics"}) )
        != 0
      for: 15m
      labels:
        severity: critical
{% endraw %}
