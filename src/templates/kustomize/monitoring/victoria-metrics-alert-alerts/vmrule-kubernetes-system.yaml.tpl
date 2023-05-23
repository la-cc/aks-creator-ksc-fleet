{% raw %}
# Source: victoria-metrics-k8s-stack/templates/rules/kubernetes-system.yaml
apiVersion: operator.victoriametrics.com/v1beta1
kind: VMRule
metadata:
  name: vmrule-kubernetes-system
spec:
  groups:
  - name: kubernetes-system
    rules:
    - alert: KubeVersionMismatch
      annotations:
        description: There are {{ $value }} different semantic versions of Kubernetes components running.
        runbook_url: https://runbooks.prometheus-operator.dev/runbooks/kubernetes/kubeversionmismatch
        summary: Different semantic versions of Kubernetes components running.
      expr: count by (cluster) (count by (git_version, cluster) (label_replace(kubernetes_build_info{job!~"kube-dns|coredns"},"git_version","$1","git_version","(v[0-9]*.[0-9]*).*"))) > 1
      for: 15m
      labels:
        severity: warning
    - alert: KubeClientErrors
      annotations:
        description: Kubernetes API server client '{{ $labels.job }}/{{ $labels.instance }}' is experiencing {{ $value | humanizePercentage }} errors.'
        runbook_url: https://runbooks.prometheus-operator.dev/runbooks/kubernetes/kubeclienterrors
        summary: Kubernetes API server client is experiencing errors.
      expr: |-
        (sum(rate(rest_client_requests_total{code=~"5.."}[5m])) by (cluster, instance, job, namespace)
          /
        sum(rate(rest_client_requests_total[5m])) by (cluster, instance, job, namespace))
        > 0.01
      for: 15m
      labels:
        severity: warning
{% endraw %}
