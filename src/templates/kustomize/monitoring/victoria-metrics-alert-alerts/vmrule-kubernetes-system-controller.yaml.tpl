{% raw %}
# Source: victoria-metrics-k8s-stack/templates/rules/kubernetes-system-controller-manager.yaml
apiVersion: operator.victoriametrics.com/v1beta1
kind: VMRule
metadata:
  name: vmrule-kubernetes-system-controller
spec:
  groups:
  - name: kubernetes-system-controller-manager
    rules:
    - alert: KubeControllerManagerDown
      annotations:
        description: KubeControllerManager has disappeared from Prometheus target discovery.
        runbook_url: https://runbooks.prometheus-operator.dev/runbooks/kubernetes/kubecontrollermanagerdown
        summary: Target disappeared from Prometheus target discovery.
      expr: absent(up{job="kube-controller-manager"} == 1)
      for: 15m
      labels:
        severity: critical
{% endraw %}