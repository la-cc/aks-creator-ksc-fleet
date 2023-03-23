apiVersion: argoproj.io/v1alpha1
kind: AppProject
metadata:
  name: bootstrap
  namespace: argocd
  # Finalizer that ensures that project is not deleted until it is not referenced by any application
  finalizers:
    - resources-finalizer.argocd.argoproj.io
spec:
  # Project description
  description: Bootstrap Project to install new applications

  # Allow manifests to deploy from any Git repos
  sourceRepos:
    # Any other repo are restricted
    - "*"

  destinations:
    - namespace: "*"
      server: "*"

  # Allow all cluster-scoped resources from being created
  clusterResourceWhitelist:
    - group: "argoproj.io"
      kind: "AppProject"
    - group: "*"
      kind: "*"

  #  # Restrict namespaced-scoped resources from being created
  namespaceResourceBlacklist:
    - group: "argoproj.io"
      kind: "AppProject"

  # Allow all namespaced-scoped resources from being created
  namespaceResourceWhitelist:
    - group: "*"
      kind: "*"

  # Enables namespace orphaned resource monitoring.
  orphanedResources:
    warn: true
