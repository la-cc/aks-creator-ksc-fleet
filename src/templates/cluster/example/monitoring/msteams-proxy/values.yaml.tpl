prometheus-msteams:
  connectors:
    # in alertmanager, this will be used as http://prometheus-msteams.msteams:2000/debug
    - debug: {{ cluster.service_catalog.monitoring.msteamsproxy.debug }}
    # in alertmanager, this will be used as http://prometheus-msteams.msteams:2000/info
    - info: {{ cluster.service_catalog.monitoring.msteamsproxy.info }}
    # in alertmanager, this will be used as http://prometheus-msteams.msteams:2000/critical
    - critical: {{ cluster.service_catalog.monitoring.msteamsproxy.critical }}