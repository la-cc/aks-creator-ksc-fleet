{% raw %}
# Source: victoria-metrics-k8s-stack/templates/rules/kube-apiserver-burnrate.rules.yaml
apiVersion: operator.victoriametrics.com/v1beta1
kind: VMRule
metadata:
  name: vmrule-apiserver-burnrate
spec:
  groups:
  - name: kube-apiserver-burnrate.rules
    rules:
    - expr: |-
        (
          (
            # too slow
            sum by (cluster) (rate(apiserver_request_slo_duration_seconds_count{job="apiserver",verb=~"LIST|GET",subresource!~"proxy|attach|log|exec|portforward"}[1d]))
            -
            (
              (
                sum by (cluster) (rate(apiserver_request_slo_duration_seconds_bucket{job="apiserver",verb=~"LIST|GET",subresource!~"proxy|attach|log|exec|portforward",scope=~"resource|",le="1"}[1d]))
                or
                vector(0)
              )
              +
              sum by (cluster) (rate(apiserver_request_slo_duration_seconds_bucket{job="apiserver",verb=~"LIST|GET",subresource!~"proxy|attach|log|exec|portforward",scope="namespace",le="5"}[1d]))
              +
              sum by (cluster) (rate(apiserver_request_slo_duration_seconds_bucket{job="apiserver",verb=~"LIST|GET",subresource!~"proxy|attach|log|exec|portforward",scope="cluster",le="30"}[1d]))
            )
          )
          +
          # errors
          sum by (cluster) (rate(apiserver_request_total{job="apiserver",verb=~"LIST|GET",code=~"5.."}[1d]))
        )
        /
        sum by (cluster) (rate(apiserver_request_total{job="apiserver",verb=~"LIST|GET"}[1d]))
      labels:
        verb: read
      record: apiserver_request:burnrate1d
    - expr: |-
        (
          (
            # too slow
            sum by (cluster) (rate(apiserver_request_slo_duration_seconds_count{job="apiserver",verb=~"LIST|GET",subresource!~"proxy|attach|log|exec|portforward"}[1h]))
            -
            (
              (
                sum by (cluster) (rate(apiserver_request_slo_duration_seconds_bucket{job="apiserver",verb=~"LIST|GET",subresource!~"proxy|attach|log|exec|portforward",scope=~"resource|",le="1"}[1h]))
                or
                vector(0)
              )
              +
              sum by (cluster) (rate(apiserver_request_slo_duration_seconds_bucket{job="apiserver",verb=~"LIST|GET",subresource!~"proxy|attach|log|exec|portforward",scope="namespace",le="5"}[1h]))
              +
              sum by (cluster) (rate(apiserver_request_slo_duration_seconds_bucket{job="apiserver",verb=~"LIST|GET",subresource!~"proxy|attach|log|exec|portforward",scope="cluster",le="30"}[1h]))
            )
          )
          +
          # errors
          sum by (cluster) (rate(apiserver_request_total{job="apiserver",verb=~"LIST|GET",code=~"5.."}[1h]))
        )
        /
        sum by (cluster) (rate(apiserver_request_total{job="apiserver",verb=~"LIST|GET"}[1h]))
      labels:
        verb: read
      record: apiserver_request:burnrate1h
    - expr: |-
        (
          (
            # too slow
            sum by (cluster) (rate(apiserver_request_slo_duration_seconds_count{job="apiserver",verb=~"LIST|GET",subresource!~"proxy|attach|log|exec|portforward"}[2h]))
            -
            (
              (
                sum by (cluster) (rate(apiserver_request_slo_duration_seconds_bucket{job="apiserver",verb=~"LIST|GET",subresource!~"proxy|attach|log|exec|portforward",scope=~"resource|",le="1"}[2h]))
                or
                vector(0)
              )
              +
              sum by (cluster) (rate(apiserver_request_slo_duration_seconds_bucket{job="apiserver",verb=~"LIST|GET",subresource!~"proxy|attach|log|exec|portforward",scope="namespace",le="5"}[2h]))
              +
              sum by (cluster) (rate(apiserver_request_slo_duration_seconds_bucket{job="apiserver",verb=~"LIST|GET",subresource!~"proxy|attach|log|exec|portforward",scope="cluster",le="30"}[2h]))
            )
          )
          +
          # errors
          sum by (cluster) (rate(apiserver_request_total{job="apiserver",verb=~"LIST|GET",code=~"5.."}[2h]))
        )
        /
        sum by (cluster) (rate(apiserver_request_total{job="apiserver",verb=~"LIST|GET"}[2h]))
      labels:
        verb: read
      record: apiserver_request:burnrate2h
    - expr: |-
        (
          (
            # too slow
            sum by (cluster) (rate(apiserver_request_slo_duration_seconds_count{job="apiserver",verb=~"LIST|GET",subresource!~"proxy|attach|log|exec|portforward"}[30m]))
            -
            (
              (
                sum by (cluster) (rate(apiserver_request_slo_duration_seconds_bucket{job="apiserver",verb=~"LIST|GET",subresource!~"proxy|attach|log|exec|portforward",scope=~"resource|",le="1"}[30m]))
                or
                vector(0)
              )
              +
              sum by (cluster) (rate(apiserver_request_slo_duration_seconds_bucket{job="apiserver",verb=~"LIST|GET",subresource!~"proxy|attach|log|exec|portforward",scope="namespace",le="5"}[30m]))
              +
              sum by (cluster) (rate(apiserver_request_slo_duration_seconds_bucket{job="apiserver",verb=~"LIST|GET",subresource!~"proxy|attach|log|exec|portforward",scope="cluster",le="30"}[30m]))
            )
          )
          +
          # errors
          sum by (cluster) (rate(apiserver_request_total{job="apiserver",verb=~"LIST|GET",code=~"5.."}[30m]))
        )
        /
        sum by (cluster) (rate(apiserver_request_total{job="apiserver",verb=~"LIST|GET"}[30m]))
      labels:
        verb: read
      record: apiserver_request:burnrate30m
    - expr: |-
        (
          (
            # too slow
            sum by (cluster) (rate(apiserver_request_slo_duration_seconds_count{job="apiserver",verb=~"LIST|GET",subresource!~"proxy|attach|log|exec|portforward"}[3d]))
            -
            (
              (
                sum by (cluster) (rate(apiserver_request_slo_duration_seconds_bucket{job="apiserver",verb=~"LIST|GET",subresource!~"proxy|attach|log|exec|portforward",scope=~"resource|",le="1"}[3d]))
                or
                vector(0)
              )
              +
              sum by (cluster) (rate(apiserver_request_slo_duration_seconds_bucket{job="apiserver",verb=~"LIST|GET",subresource!~"proxy|attach|log|exec|portforward",scope="namespace",le="5"}[3d]))
              +
              sum by (cluster) (rate(apiserver_request_slo_duration_seconds_bucket{job="apiserver",verb=~"LIST|GET",subresource!~"proxy|attach|log|exec|portforward",scope="cluster",le="30"}[3d]))
            )
          )
          +
          # errors
          sum by (cluster) (rate(apiserver_request_total{job="apiserver",verb=~"LIST|GET",code=~"5.."}[3d]))
        )
        /
        sum by (cluster) (rate(apiserver_request_total{job="apiserver",verb=~"LIST|GET"}[3d]))
      labels:
        verb: read
      record: apiserver_request:burnrate3d
    - expr: |-
        (
          (
            # too slow
            sum by (cluster) (rate(apiserver_request_slo_duration_seconds_count{job="apiserver",verb=~"LIST|GET",subresource!~"proxy|attach|log|exec|portforward"}[5m]))
            -
            (
              (
                sum by (cluster) (rate(apiserver_request_slo_duration_seconds_bucket{job="apiserver",verb=~"LIST|GET",subresource!~"proxy|attach|log|exec|portforward",scope=~"resource|",le="1"}[5m]))
                or
                vector(0)
              )
              +
              sum by (cluster) (rate(apiserver_request_slo_duration_seconds_bucket{job="apiserver",verb=~"LIST|GET",subresource!~"proxy|attach|log|exec|portforward",scope="namespace",le="5"}[5m]))
              +
              sum by (cluster) (rate(apiserver_request_slo_duration_seconds_bucket{job="apiserver",verb=~"LIST|GET",subresource!~"proxy|attach|log|exec|portforward",scope="cluster",le="30"}[5m]))
            )
          )
          +
          # errors
          sum by (cluster) (rate(apiserver_request_total{job="apiserver",verb=~"LIST|GET",code=~"5.."}[5m]))
        )
        /
        sum by (cluster) (rate(apiserver_request_total{job="apiserver",verb=~"LIST|GET"}[5m]))
      labels:
        verb: read
      record: apiserver_request:burnrate5m
    - expr: |-
        (
          (
            # too slow
            sum by (cluster) (rate(apiserver_request_slo_duration_seconds_count{job="apiserver",verb=~"LIST|GET",subresource!~"proxy|attach|log|exec|portforward"}[6h]))
            -
            (
              (
                sum by (cluster) (rate(apiserver_request_slo_duration_seconds_bucket{job="apiserver",verb=~"LIST|GET",subresource!~"proxy|attach|log|exec|portforward",scope=~"resource|",le="1"}[6h]))
                or
                vector(0)
              )
              +
              sum by (cluster) (rate(apiserver_request_slo_duration_seconds_bucket{job="apiserver",verb=~"LIST|GET",subresource!~"proxy|attach|log|exec|portforward",scope="namespace",le="5"}[6h]))
              +
              sum by (cluster) (rate(apiserver_request_slo_duration_seconds_bucket{job="apiserver",verb=~"LIST|GET",subresource!~"proxy|attach|log|exec|portforward",scope="cluster",le="30"}[6h]))
            )
          )
          +
          # errors
          sum by (cluster) (rate(apiserver_request_total{job="apiserver",verb=~"LIST|GET",code=~"5.."}[6h]))
        )
        /
        sum by (cluster) (rate(apiserver_request_total{job="apiserver",verb=~"LIST|GET"}[6h]))
      labels:
        verb: read
      record: apiserver_request:burnrate6h
    - expr: |-
        (
          (
            # too slow
            sum by (cluster) (rate(apiserver_request_slo_duration_seconds_count{job="apiserver",verb=~"POST|PUT|PATCH|DELETE",subresource!~"proxy|attach|log|exec|portforward"}[1d]))
            -
            sum by (cluster) (rate(apiserver_request_slo_duration_seconds_bucket{job="apiserver",verb=~"POST|PUT|PATCH|DELETE",subresource!~"proxy|attach|log|exec|portforward",le="1"}[1d]))
          )
          +
          sum by (cluster) (rate(apiserver_request_total{job="apiserver",verb=~"POST|PUT|PATCH|DELETE",code=~"5.."}[1d]))
        )
        /
        sum by (cluster) (rate(apiserver_request_total{job="apiserver",verb=~"POST|PUT|PATCH|DELETE"}[1d]))
      labels:
        verb: write
      record: apiserver_request:burnrate1d
    - expr: |-
        (
          (
            # too slow
            sum by (cluster) (rate(apiserver_request_slo_duration_seconds_count{job="apiserver",verb=~"POST|PUT|PATCH|DELETE",subresource!~"proxy|attach|log|exec|portforward"}[1h]))
            -
            sum by (cluster) (rate(apiserver_request_slo_duration_seconds_bucket{job="apiserver",verb=~"POST|PUT|PATCH|DELETE",subresource!~"proxy|attach|log|exec|portforward",le="1"}[1h]))
          )
          +
          sum by (cluster) (rate(apiserver_request_total{job="apiserver",verb=~"POST|PUT|PATCH|DELETE",code=~"5.."}[1h]))
        )
        /
        sum by (cluster) (rate(apiserver_request_total{job="apiserver",verb=~"POST|PUT|PATCH|DELETE"}[1h]))
      labels:
        verb: write
      record: apiserver_request:burnrate1h
    - expr: |-
        (
          (
            # too slow
            sum by (cluster) (rate(apiserver_request_slo_duration_seconds_count{job="apiserver",verb=~"POST|PUT|PATCH|DELETE",subresource!~"proxy|attach|log|exec|portforward"}[2h]))
            -
            sum by (cluster) (rate(apiserver_request_slo_duration_seconds_bucket{job="apiserver",verb=~"POST|PUT|PATCH|DELETE",subresource!~"proxy|attach|log|exec|portforward",le="1"}[2h]))
          )
          +
          sum by (cluster) (rate(apiserver_request_total{job="apiserver",verb=~"POST|PUT|PATCH|DELETE",code=~"5.."}[2h]))
        )
        /
        sum by (cluster) (rate(apiserver_request_total{job="apiserver",verb=~"POST|PUT|PATCH|DELETE"}[2h]))
      labels:
        verb: write
      record: apiserver_request:burnrate2h
    - expr: |-
        (
          (
            # too slow
            sum by (cluster) (rate(apiserver_request_slo_duration_seconds_count{job="apiserver",verb=~"POST|PUT|PATCH|DELETE",subresource!~"proxy|attach|log|exec|portforward"}[30m]))
            -
            sum by (cluster) (rate(apiserver_request_slo_duration_seconds_bucket{job="apiserver",verb=~"POST|PUT|PATCH|DELETE",subresource!~"proxy|attach|log|exec|portforward",le="1"}[30m]))
          )
          +
          sum by (cluster) (rate(apiserver_request_total{job="apiserver",verb=~"POST|PUT|PATCH|DELETE",code=~"5.."}[30m]))
        )
        /
        sum by (cluster) (rate(apiserver_request_total{job="apiserver",verb=~"POST|PUT|PATCH|DELETE"}[30m]))
      labels:
        verb: write
      record: apiserver_request:burnrate30m
    - expr: |-
        (
          (
            # too slow
            sum by (cluster) (rate(apiserver_request_slo_duration_seconds_count{job="apiserver",verb=~"POST|PUT|PATCH|DELETE",subresource!~"proxy|attach|log|exec|portforward"}[3d]))
            -
            sum by (cluster) (rate(apiserver_request_slo_duration_seconds_bucket{job="apiserver",verb=~"POST|PUT|PATCH|DELETE",subresource!~"proxy|attach|log|exec|portforward",le="1"}[3d]))
          )
          +
          sum by (cluster) (rate(apiserver_request_total{job="apiserver",verb=~"POST|PUT|PATCH|DELETE",code=~"5.."}[3d]))
        )
        /
        sum by (cluster) (rate(apiserver_request_total{job="apiserver",verb=~"POST|PUT|PATCH|DELETE"}[3d]))
      labels:
        verb: write
      record: apiserver_request:burnrate3d
    - expr: |-
        (
          (
            # too slow
            sum by (cluster) (rate(apiserver_request_slo_duration_seconds_count{job="apiserver",verb=~"POST|PUT|PATCH|DELETE",subresource!~"proxy|attach|log|exec|portforward"}[5m]))
            -
            sum by (cluster) (rate(apiserver_request_slo_duration_seconds_bucket{job="apiserver",verb=~"POST|PUT|PATCH|DELETE",subresource!~"proxy|attach|log|exec|portforward",le="1"}[5m]))
          )
          +
          sum by (cluster) (rate(apiserver_request_total{job="apiserver",verb=~"POST|PUT|PATCH|DELETE",code=~"5.."}[5m]))
        )
        /
        sum by (cluster) (rate(apiserver_request_total{job="apiserver",verb=~"POST|PUT|PATCH|DELETE"}[5m]))
      labels:
        verb: write
      record: apiserver_request:burnrate5m
    - expr: |-
        (
          (
            # too slow
            sum by (cluster) (rate(apiserver_request_slo_duration_seconds_count{job="apiserver",verb=~"POST|PUT|PATCH|DELETE",subresource!~"proxy|attach|log|exec|portforward"}[6h]))
            -
            sum by (cluster) (rate(apiserver_request_slo_duration_seconds_bucket{job="apiserver",verb=~"POST|PUT|PATCH|DELETE",subresource!~"proxy|attach|log|exec|portforward",le="1"}[6h]))
          )
          +
          sum by (cluster) (rate(apiserver_request_total{job="apiserver",verb=~"POST|PUT|PATCH|DELETE",code=~"5.."}[6h]))
        )
        /
        sum by (cluster) (rate(apiserver_request_total{job="apiserver",verb=~"POST|PUT|PATCH|DELETE"}[6h]))
      labels:
        verb: write
      record: apiserver_request:burnrate6h
{% endraw %}