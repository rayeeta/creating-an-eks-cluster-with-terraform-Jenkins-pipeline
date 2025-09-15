# How to create and connect to your EKS cluster from your local terminal: follow these steps:

### Prerequisites

Before you can connect to your EKS clusters:

Install required tools locally:

Terraform
 (you should already have 1.13.1).

AWS CLI v2
.

kubectl
.

(Optional but recommended) eksctl
 (handy for cluster ops).

### AWS account setup:

*An IAM user/role with sufficient permissions:*

AmazonEKSClusterPolicy

AmazonEKSWorkerNodePolicy

AmazonEKS_CNI_Policy

AmazonEC2ContainerRegistryReadOnly

AdministratorAccess (if testing/demo).

### AWS credentials configured locally:

aws configure


### Provide:

AWS Access Key ID

AWS Secret Access Key

Default region → us-west-2

Default output format → json

### Terraform setup:

Run terraform init (downloads providers).

Run terraform apply (deploys VPC, EKS clusters, node groups).

### Commands to Connect to a Cluster

After your clusters are created (bmt-demo-cluster-1 and bmt-demo-cluster-2):

1. Update kubeconfig for a cluster

Use the AWS CLI to merge cluster credentials into your ~/.kube/config:

### Connect to Cluster 1
aws eks update-kubeconfig --region us-west-2 --name bmt-demo-cluster-1 --alias bmt1

### Connect to Cluster 2
aws eks update-kubeconfig --region us-west-2 --name bmt-demo-cluster-2 --alias bmt2


--alias ensures your kubeconfig stores them under different contexts (bmt1 and bmt2).

If you omit --alias, the context name defaults to the cluster name.

### Switching Between Clusters
2. View available contexts
   
kubectl config get-contexts

Example output:
CURRENT   NAME    CLUSTER                 AUTHINFO              NAMESPACE
*         bmt1    arn:aws:eks:us-west-2:123456789012:cluster/bmt-demo-cluster-1   arn:aws:eks:...:bmt-demo-cluster-1   default
          bmt2    arn:aws:eks:us-west-2:123456789012:cluster/bmt-demo-cluster-2   arn:aws:eks:...:bmt-demo-cluster-2   default

3. Switch to a cluster context
# Switch to Cluster 1
kubectl config use-context bmt1

# Switch to Cluster 2
kubectl config use-context bmt2

4. Verify connection
kubectl get nodes
kubectl get pods -A

### Switching Between Clusters in Different Regions / AZs

If your clusters are in different regions (e.g., us-west-2 and us-east-1):

aws eks update-kubeconfig --region us-east-1 --name cluster-in-east --alias east-cluster

aws eks update-kubeconfig --region us-west-2 --name cluster-in-west --alias west-cluster


Then switch contexts the same way with kubectl config use-context.

Availability Zones (AZs) don’t affect kubeconfig switching.

They only matter for subnet/instance placement inside the cluster.

### Summary Workflow

Deploy cluster(s)

terraform init

terraform fmt

terrafrom validate

terraform plan

terraform apply -auto-approve


### Get cluster credentials

aws eks update-kubeconfig --region us-west-2 --name bmt-demo-cluster-1 --alias bmt1

aws eks update-kubeconfig --region us-west-2 --name bmt-demo-cluster-2 --alias bmt2


### List contexts

kubectl config get-contexts


### Switch cluster

kubectl config use-context bmt1   # or bmt2


### Verify nodes

kubectl get nodes


⚡ Pro Tip: You can use kubectx (a kubectl context switcher tool) to quickly swap between clusters with short commands:

kubectx bmt1
kubectx bmt2

