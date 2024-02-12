from schema import Schema, Optional

config_schema = Schema({

    "clusters": [
        {
            "name": str,
            "defaults": {
                "storageClass": str,
                Optional("clusterIssuerDNS", default="letsencrypt-dns"): str,
                Optional("clusterIssuerHTTP", default="letsencrypt-http"): str,
            },
            "service_catalog": {
                "argocd_core": {
                    "initializer": [
                        {
                            Optional("application_enabled", default=True): bool,
                            Optional("git_repository_enabled", default=False): bool,
                            "manifestId": str,
                            "git_repository_URL": str,
                            "git_repository_path": str,
                            Optional("git_repository_PAT"): str,
                            Optional("git_repository_user"): str,
                            Optional("git_repository_private", default=False): bool,
                            Optional("targetRevision", default="main"): str,
                        },
                    ],
                    Optional("external_secret_enabled", default=True): bool,
                    Optional("ingress"): {
                        Optional("enabled", default=False): bool,
                        Optional("hostname"): str,
                        Optional("issuer", default="letsencrypt-dns"): str
                    }
                },
                Optional("externalDNS"): {
                    Optional("enabled", default=False): bool,
                    Optional("resource_group"): str,
                    Optional("tenantID"): str,
                    Optional("subscriptionID"): str,
                    Optional("userAssignedIdentityID"): str,
                    Optional("domain_filters"): list,
                    Optional("txtOwnerId"): str,
                },
                Optional("mail"): {
                    Optional("ingress"): {
                        Optional("enabled", default=False): bool,
                        Optional("hostname"): str
                    }
                },

                Optional("security"): {
                    Optional("clusterIssuerDNS"): {
                        Optional("enabled", default=False): bool,
                        Optional("e_mail"): str,
                        Optional("subscriptionID"): str,
                        Optional("resourceGroupName"): str,
                        Optional("hostedZoneName"): str,
                    },
                    Optional("clusterIssuerHTTP"): {
                        Optional("enabled", default=False): bool,
                        Optional("e_mail"): str
                    },
                    Optional("externalSecrets"): {
                        Optional("clusterSecretStoreName", default="azure-cluster-secret-store"): str,
                        Optional("identityId"): str,
                        "vaultUrl": str
                    }

                },

                Optional("minio_operator"): {
                    Optional("enabled", default=False): bool,
                    Optional("operatorReplicaCount", default=2): int,
                    Optional("consoleReplicaCount", default=1): int,
                    Optional("ingress"): {
                        Optional("enabled", default=False): bool,
                        Optional("hostname"): str,
                        Optional("annotationClusterIssuer", default="letsencrypt-dns"): str
                    }

                },

                Optional("monitoring"): {
                    Optional("alertrules"): {
                        Optional("diskalerts", default="true"): str,
                        Optional("hostalerts", default="true"): str,
                        Optional("kubernetesalerts", default="true"): str,
                        Optional("podalerts", default="true"): str
                    },
                    "grafana": {
                        "adminUser": str,
                        "adminPassword": str,
                        "hostname": str,
                        "azure": {
                            "clientid": str,
                            "clientsecret": str,
                            "authurl": str,
                            "tokenurl": str,
                            "allowedgroups": str
                        }
                    },
                    "minio": {
                        "userConfiguration": {
                            "name": str,
                            "accessKey": str,
                            "secretKey": str
                        },
                        "tenant": {
                            "name": str,
                            "pools": [
                                {
                                    "servers": int,
                                    "name": str,
                                    "volumesPerServer": int,
                                    "size": int
                                }
                            ],
                            "buckets": [
                                {
                                    "name": str,
                                    "objectLock": str,
                                    "region": str
                                }
                            ],
                            "serviceAccountName": str,
                            Optional("ingress"): {
                                Optional("api"): {
                                    Optional("enabled", default="false"): str,
                                    Optional("host"): str
                                },
                                Optional("console"): {
                                    Optional("enabled", default="false"): str,
                                    Optional("host"): str
                                }
                            }
                        },
                    },
                    "msteamsproxy": {
                        "debug": str,
                        "info": str,
                        "critical": str
                    },
                    Optional("loki"): {
                        Optional("read"): {
                            Optional("replicaCount", default=2): int,
                            Optional("persistence"): {
                                Optional("autoDeletePVC", default=True): bool,
                                Optional("size", default=5): int,
                            }
                        },
                        Optional("write"): {
                            Optional("replicaCount", default=2): int,
                            Optional("persistence"): {
                                Optional("autoDeletePVC", default=True): bool,
                                Optional("size", default=5): int,
                            }
                        },
                        Optional("backend"): {
                            Optional("replicaCount", default=2): int,
                            Optional("persistence"): {
                                Optional("autoDeletePVC", default=True): bool,
                                Optional("size", default=5): int,
                            }
                        },
                    },
                    "victoriaMetrics": {
                        Optional("persistentStorageSize", default="16Gi"): str,
                        "vmagent": {
                            Optional("enabled", default=False): bool,
                            "host": str
                        }
                    },
                    "victoriaMetricsAlert": {
                        "hostname": str
                    },
                    "prometheusalertmanager": {
                        Optional("enabled", default=False): bool,
                        "hostname": str
                    }
                }

            }

        }
    ],

    "ksc": {
        "repoURL": str
    }
})
