#https://github.com/bitnami-labs/sealed-secrets
tls:
  crt: overlay_me_crt
  key: overlay_me_key

sealed-secrets:
  crd:
    create: false
  rbac:
    pspEnabled: true
