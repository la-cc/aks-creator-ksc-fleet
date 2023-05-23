{% raw %}
# Source: victoria-metrics-k8s-stack/templates/rules/kube-apiserver-histogram.rules.yaml
apiVersion: operator.victoriametrics.com/v1beta1
kind: VMRule
metadata:
  name: vmrule-apiserver-histogramm
spec:
  groups:
  - name: kube-apiserver-histogram.rules
    rules:
    - expr: histogram_quantile(0.99, sum by (cluster, le, resource) (rate(apiserver_request_slo_duration_seconds_bucket{job="apiserver",verb=~"LIST|GET",subresource!~"proxy|attach|log|exec|portforward"}[5m]))) > 0
      labels:
        quantile: '0.99'
        verb: read
      record: cluster_quantile:apiserver_request_slo_duration_seconds:histogram_quantile
    - expr: histogram_quantile(0.99, sum by (cluster, le, resource) (rate(apiserver_request_slo_duration_seconds_bucket{job="apiserver",verb=~"POST|PUT|PATCH|DELETE",subresource!~"proxy|attach|log|exec|portforward"}[5m]))) > 0
      labels:
        quantile: '0.99'
        verb: write
      record: cluster_quantile:apiserver_request_slo_duration_seconds:histogram_quantile
{% endraw %}