# AKS Creator

This tool image allows you to create and manage the configuration files of a AKS Kubernetes repository.

## Getting started

In order to be able to use this image, it must be started in the desired AKS Cluster repository using Docker or Podman.
Furthermore, the repository directory must be mounted in the container.
To avoid permission errors, it is recommended to do this with the permissions of the executing user.

### Igor

We will use the `igor`.
The tool opens a shell in your favorite docker container mounting your current workspace into the container.

The following steps are executed:

- Start the image
- Mount necessary directories
- Set permissions
- Clean up

To install `igor` just download the `igor.sh` and store it in your `$PATH` like this:

    sudo curl https://raw.githubusercontent.com/la-cc/igor/main/igor.sh -o /usr/local/bin/igor
    sudo chmod +x /usr/local/bin/igor

#### Configure igor

Running `igor` without configuration will launch a busybox image. In order to use the tool with the AKS Creator image,
a configuration file is required.

> **_NOTE:_** You can get the recent tag from [la-cc/aks-creator-argocd-cockpit](https://github.com/la-cc/aks-creator-argocd-cockpit/tags)

Open the file `.igor.sh` in your preferred editor and use the following settings to configure `igor`:

    # select docker image
    IGOR_DOCKER_IMAGE=ghcr.io/la-cc/aks-creator-core:0.0.2
    IGOR_DOCKER_COMMAND=                                  # run this command inside the docker container
    IGOR_DOCKER_PULL=0                                    # force pulling the image before starting the container (0/1)
    IGOR_DOCKER_RM=1                                      # remove container on exit (0/1)
    IGOR_DOCKER_TTY=1                                     # open an interactive tty (0/1)
    IGOR_DOCKER_USER=$(id -u)                             # run commands inside the container with this user
    IGOR_DOCKER_GROUP=$(id -g)                            # run commands inside the container with this group
    IGOR_DOCKER_ARGS=''                                   # default arguments to docker run
    IGOR_PORTS=''                                         # space separated list of ports to expose
    IGOR_MOUNT_PASSWD=1                                   # mount /etc/passwd inside the container (0/1)
    IGOR_MOUNT_GROUP=1                                    # mount /etc/group inside the container (0/1)
    IGOR_MOUNTS_RO="${HOME}/.azure"                       # space separated list of volumes to mount read only
    IGOR_MOUNTS_RW=''                                     # space separated list of volumes to mount read write
    IGOR_WORKDIR=${PWD}                                   # use this workdir inside the container
    IGOR_WORKDIR_MODE=rw                                  # mount the workdir with this mode (ro/rw)
    IGOR_ENV=''                                           # space separated list of environment variables set inside the container

### Workflow

The following workflow is recommended as part of a aks cluster creation.

| No.                    | Step                                              | required | Tool                |
| ---------------------- | ------------------------------------------------- | -------- | ------------------- |
| [0](#CertificatesInit) | Generate a x509 10 ten years valid key pair       | no       | `certificates-init` |
| [1](#InitConfig)       | Initialize empty configuration file.              | yes      | `config-init`       |
| [2](#FillMissing)      | Fill missing fields in configuration file.        | yes      | -                   |
| [3](#TemplateConfig)   | Template the whole aks platform folder structure. | yes      | `config-template`   |

### <a id="CertificatesInit"></a>0. Generate a x509 10 ten years valid key pair (Optional)

**Requirements**:

The step generates and prints the cert and the corresponding key Base64 on the console.
The key pair can then be used for the sealed secret operator. You will find more in the config file under the tls section.

Then execute the script (from inside the aks-creator-ksc-fleet container):

    certificates-init

### <a id="InitConfig"></a>1. Initialize empty configuration file

**Requirements**: none

Create an empty `config.yaml`.
This already contains the necessary structure and placeholders for the values, as required in the following step.
To do so simply execute the script (from inside the aks-creator-core container):

    config-init

You will get a `config.yaml` that can be filled by you.

### <a id="FillMissing"></a>2. Fill missing fields in `config.yaml`

**Requirements**:

- `config.yaml` of [1. 1. Get configuration file config.yaml](#GetConfig)

You can get more information from [00. Configuration Options for `config.yaml`](#ConfigOptions)

### <a id="TemplateConfig"></a>3. Template the AKS folder structure from `config.yaml`

**Requirements**:

- `config.yaml` of [1. 1. Get configuration file config.yaml](#GetConfig)

To do so simply execute the script (from inside the aks-creator-core container):

    config-template

### Minimum necessary configuration

```
---
# ArgoCD KSC Fleet Cluster
clusters:
  - name: <aks-val.....>
    service_catalog:
      argocd_core:
        git_repository_URL: <https://dev.azure.com/OGRA/...>
        git_repository_path: <argocd-applicationsets/env/...>
        ingress: {}
      externalDNS: {}
      security: {}
        clusterIssuerDNS: {}
        clusterIssuerHTTP: {}
      sealed_secrets: {}
        tls: {}

ksc:
  repoURL: <https://dev.azure.com/OGRA/...>
```

### Maximum possible configuration:

```
---
# ArgoCD KSC Fleet Cluster Configuration
clusters:
  - name: <aks-val....>
    service_catalog:
      argocd_core:
        git_repository_URL: <https://dev.azure.com/OGRA/...>
        git_repository_path: <argocd-applicationsets/env/...>
        git_repository_private: true
        git_repository_PAT: <kt....>
        git_repository_user: <ORGA>
        ingress:
          enable: true
          hostname: <argocd.val...example.com>
          issuer: <letsencrypt-dns>
      # You don't disable the helm chart by setting enable:false, because the chart will be used by other cluster as well. You disable only the custom value for you cluster.
      externalDNS:
        enable: true
        resource_group: <rg-val...>
        tenantID: <6a.....>
        subscriptionID: <e18....>
        domain_filters:
          - <val...example.com>
        txtOwnerId: <aks-val....>
      security:
        clusterIssuerDNS:
          enable: true
          e_mail: <testuser@example.com>
          subscriptionID: <e18....>
          resourceGroupName: <rg-va...>
          hostedZoneName: <val...example.com>
        clusterIssuerHTTP:
          enable: true
          e_mail: <testuser@example.com>
      # You don't disable the helm chart by setting enable:false, because the chart will be used by other cluster as well. You disable only the custom value for you cluster.
      sealed_secrets:
        tls:
          enable: true
          crt: <"skisjcscs...">
          key: <"sxssikcmc...">

ksc:
  repoURL: <https://dev.azure.com/OGRA/...>
```
