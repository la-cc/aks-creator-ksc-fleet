victoria-metrics-operator:
  image:
    repository: victoriametrics/operator
  env:
    #-- available env variables found here: https://docs.victoriametrics.com/operator/vars.html
    - name: VM_VMALERTDEFAULT_CONFIGRELOADIMAGE
      value: jimmidyson/configmap-reload:v0.3.0
    - name: VM_VMAGENTDEFAULT_CONFIGRELOADIMAGE
      value: ghcr.io/prometheus-operator/prometheus-config-reloader:v0.64.1
    - name: VM_VMALERTMANAGER_CONFIGRELOADERIMAGE
      value: jimmidyson/configmap-reload:v0.3.0