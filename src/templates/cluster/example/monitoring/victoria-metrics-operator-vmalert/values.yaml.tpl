vmalert:
  datasource: "http://victoria-metrics-cluster-vmselect.victoria-metrics:8481/select/0/prometheus"
  notifiers: "http://vmalertmanager-alertmanager.victoria-metrics:9093/"
  remoteRead: "http://victoria-metrics-cluster-vmselect.victoria-metrics:8481/select/0/prometheus"
  remoteWrite: "http://victoria-metrics-cluster-vminsert.victoria-metrics:8480/insert/0/prometheus"