# Local Kubernetes Cluster Setup with K3d and Flux

This guide will walk you through setting up a local Kubernetes cluster with K3d and installing Flux using a Taskfile. The steps include installing K3d, creating a cluster, installing Flux, and configuring it with your GitHub repository.

## Prerequisites

- [Docker](https://www.docker.com/products/docker-desktop) must be installed and running.
- [Helm](https://helm.sh/docs/intro/install/) must be installed.
- [kubectl](https://kubernetes.io/docs/tasks/tools/#kubectl) must be installed.
- [flux cli](https://fluxcd.io/flux/installation/) must be installed
- [SOPS](https://github.com/getsops/sops/releases) must be installed.
- [AGE](https://github.com/FiloSottile/age?tab=readme-ov-file#installation) must be installed.


## Install Task

### macOS

1. Install Task using Homebrew:
    ```sh
    brew install go-task/tap/go-task
    ```

### Linux

1. Download the Task binary:
    ```sh
    sh -c "$(curl -fsSL https://raw.githubusercontent.com/go-task/task/master/install.sh)"
    ```

2. Make the binary executable and move it to your PATH:
    ```sh
    chmod +x ./bin/task
    sudo mv ./bin/task /usr/local/bin/
    ```

## Clone the Repository

1. Clone this repository:
    ```sh
    git clone https://github.com/<your-github-username>/Simplifying-GitOps-with-FluxCD
    cd Simplifying-GitOps-with-FluxCD
    ```

## Fork the Repository

Before running the setup, you need to fork the repository:

1. Go to [https://github.com/PacktPublishing/Simplifying-GitOps-with-FluxCD](https://github.com/PacktPublishing/Simplifying-GitOps-with-FluxCD) and fork the repository to your GitHub account.

## Run the Setup

1. Run the setup task to create and configure the local Kubernetes cluster:
    ```sh
    task setup
    ```

## Tasks Overview

The `setup` task will perform the following steps:

1. **Install K3d**: Installs K3d for managing the Kubernetes cluster.
2. **Create Cluster**: Creates a new Kubernetes cluster with K3d.
3. **Verify Cluster**: Verifies that the Kubernetes cluster is running.
4. **Switch Context**: Switches the context to the new K3d cluster.
5. **Install Flux Operator**: Installs the Flux operator using Helm.
6. **Generate SSH Key**: Generates an SSH key for Flux.
7. **Display Public Key**: Displays the public SSH key for you to add to your GitHub repository.
8. **Wait for Key Copy**: Waits for you to add the SSH key to your GitHub repository.
9. **Create Flux Secret**: Creates a Flux secret with the private SSH key.
10. **Generate AGE Key**: Generates an AGE key for encrypting secrets.
11. **Create SOPS Secret**: Creates a Kubernetes secret for SOPS with the AGE key.
12. **Apply Flux Instance**: Deploys the Flux instance CRD.
13. **Create AWS Credentials File**: Prompts you to create an AWS credentials file.
14. **Dry Run Create AWS Creds**: Creates a local AWS credentials YAML file.
15. **Encrypt AWS Creds**: Encrypts the AWS credentials file using AGE.
16. **Push AWS Creds to Repo**: Prompts you to push the encrypted AWS credentials file to your GitHub repository.
19. **Print Setup Complete**: Prints a message indicating the setup is complete.

## Author

Georgi Lazarov