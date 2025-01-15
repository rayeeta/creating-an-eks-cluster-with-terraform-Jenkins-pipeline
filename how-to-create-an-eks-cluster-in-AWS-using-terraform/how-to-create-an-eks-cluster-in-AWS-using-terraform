# To connect to your EKS cluster from your local Git Bash terminal using Terraform, follow these steps:

1. *Install AWS CLI*: If you haven't already, install the AWS CLI.
2. *Install kubectl*: Ensure you have kubectl installed for controlling the Kubernetes cluster.
3. *Install eksctl*: This is a command-line tool for EKS to simplify cluster management. 

### Step-by-Step Guide

#### 1. Install AWS CLI

If you haven't installed the AWS CLI yet, you can download and install it from [AWS CLI installation guide](https://docs.aws.amazon.com/cli/latest/userguide/getting-started-install.html).

Verify the installation:

aws --version


#### 2. Configure AWS CLI

Configure your AWS CLI with your credentials:

aws configure

This will require you to input your AWS Access Key ID, Secret Access Key, region, and output format.

#### 3. Install kubectl

You can install kubectl by following the [official guide](https://kubernetes.io/docs/tasks/tools/install-kubectl/).

For example, on Windows:

curl -LO "https://storage.googleapis.com/kubernetes-release/release/$(curl -s https://storage.googleapis.com/kubernetes-release/release/stable.txt)/bin/windows/amd64/kubectl.exe"
chmod +x kubectl.exe


Verify the installation:

kubectl version --client


#### 4. Install eksctl

You can install eksctl by following the [official guide](https://eksctl.io/).

For example, to install eksctl on Windows, you can use Chocolatey:

choco install eksctl


Verify the installation:

eksctl version


#### 5. Update kubeconfig

Update your kubeconfig to connect to your EKS cluster. Run:

aws eks --region <your-region> update-kubeconfig --name <your-cluster-name>



For example:

aws eks --region us-west-1 update-kubeconfig --name devops-tutorial-cluster-2


This command updates (or creates) your kubeconfig file located in `~/.kube/config
