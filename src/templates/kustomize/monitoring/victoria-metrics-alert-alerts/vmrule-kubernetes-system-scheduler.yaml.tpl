{% raw %}
# Source: victoria-metrics-k8s-stack/templates/rules/kubernetes-system-scheduler.yaml
apiVersion: operator.victoriametrics.com/v1beta1
kind: VMRule
metadata:
  name: vmrule-kubernetes-system-scheduler
spec:
  groups:
  - name: kubernetes-system-scheduler
    rules:
    - alert: KubeSchedulerDown
      annotations:
        description: KubeScheduler has disappeared from Prometheus target discovery.
        runbook_url: https://runbooks.prometheus-operator.dev/runbooks/kubernetes/kubeschedulerdown
        summary: Target disappeared from Prometheus target discovery.
      expr: absent(up{job="kube-scheduler"} == 1)
      for: 15m
      labels:
        severity: critical
{% endraw %}