{% raw %}
# Source: victoria-metrics-k8s-stack/templates/rules/kubelet.rules.yaml
apiVersion: operator.victoriametrics.com/v1beta1
kind: VMRule
metadata:
  name: vmrule-kubelet
spec:
  groups:
  - name: kubelet.rules
    rules:
    - expr: histogram_quantile(0.99, sum(rate(kubelet_pleg_relist_duration_seconds_bucket[5m])) by (cluster, instance, le) * on(cluster, instance) group_left(node) kubelet_node_name{job="kubelet", metrics_path="/metrics"})
      labels:
        quantile: '0.99'
      record: node_quantile:kubelet_pleg_relist_duration_seconds:histogram_quantile
    - expr: histogram_quantile(0.9, sum(rate(kubelet_pleg_relist_duration_seconds_bucket[5m])) by (cluster, instance, le) * on(cluster, instance) group_left(node) kubelet_node_name{job="kubelet", metrics_path="/metrics"})
      labels:
        quantile: '0.9'
      record: node_quantile:kubelet_pleg_relist_duration_seconds:histogram_quantile
    - expr: histogram_quantile(0.5, sum(rate(kubelet_pleg_relist_duration_seconds_bucket[5m])) by (cluster, instance, le) * on(cluster, instance) group_left(node) kubelet_node_name{job="kubelet", metrics_path="/metrics"})
      labels:
        quantile: '0.5'
      record: node_quantile:kubelet_pleg_relist_duration_seconds:histogram_quantile
{% endraw %}
