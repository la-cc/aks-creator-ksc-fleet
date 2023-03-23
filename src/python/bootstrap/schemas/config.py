from schema import Schema, Optional

config_schema = Schema({

    "clusters": [
        {
            "name": str,
            "service_catalog": {
                "argocd_core": {
                    "git_repository_URL": str,
                    "git_repository_path": str,
                    Optional("git_repository_private", default=False): bool,
                    Optional("git_repository_PAT"): str,
                    Optional("git_repository_user"): str,
                    Optional("ingress"): {
                        Optional("enable", default=False): bool,
                        Optional("hostname"): str,
                        Optional("issuer", default="letsencrypt-dns"): str
                    }
                },
                Optional("externalDNS"): {
                    Optional("enable", default=False): bool,
                    Optional("resource_group"): str,
                    Optional("tenantID"): str,
                    Optional("subscriptionID"): str,
                    Optional("domain_filters"): list,
                    Optional("txtOwnerId"): str,
                },
                Optional("sealed_secrets"): {
                    Optional("enable", default=False): bool,
                    Optional("tls"): {
                        Optional("crt"): str,
                        Optional("key"): str
                    }
                },

                Optional("security"): {
                    Optional("clusterIssuerDNS"): {
                        Optional("enable", default=False): bool,
                        Optional("e_mail"): str,
                        Optional("subscriptionID"): str,
                        Optional("resourceGroupName"): str,
                        Optional("hostedZoneName"): str,
                    },
                    Optional("clusterIssuerHTTP"): {
                        Optional("enable", default=False): bool,
                        Optional("e_mail"): str
                    }
                }

            }
        }
    ],

    "ksc": {
        "repoURL": str
    }
})
