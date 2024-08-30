#### Commands

```bash
# install ArgoCD in k8s
kubectl create namespace argocd
kubectl apply -n argocd -f https://raw.githubusercontent.com/argoproj/argo-cd/stable/manifests/install.yaml

# access ArgoCD UI
kubectl get svc -n argocd
kubectl port-forward svc/argocd-server 8080:443 -n argocd

# login with admin user and below token (as in documentation):
kubectl -n argocd get secret argocd-initial-admin-secret -o jsonpath="{.data.password}" | base64 --decode && echo

# you can change and delete init password

```
</br>

#### Links

* Config repo: (https://github.com/rayeeta/argocd-project/tree/master)
  
* Docker repo: [https://hub.docker.com/repository/docker/ereta19/argocdproject/general](https://hub.docker.com/repository/docker/ereta19/argocdproject/general)

* Install ArgoCD: [https://argo-cd.readthedocs.io/en/stable/getting_started/#1-install-argo-cd](https://argo-cd.readthedocs.io/en/stable/getting_started/#1-install-argo-cd)

* Login to ArgoCD: [https://argo-cd.readthedocs.io/en/stable/getting_started/#4-login-using-the-cli](https://argo-cd.readthedocs.io/en/stable/getting_started/#4-login-using-the-cli)

* ArgoCD Configuration: [https://argo-cd.readthedocs.io/en/stable/operator-manual/declarative-setup/](https://argo-cd.readthedocs.io/en/stable/operator-manual/declarative-setup/)


# What is ArgoCD
Argo CD is an open-source continuous delivery (CD) tool designed for Kubernetes applications that follows the GitOps methodology. It enables users to manage application deployments by continuously monitoring the desired state defined in a Git repository and comparing it to the actual state in the Kubernetes cluster. Argo CD automatically reconciles the differences when discrepancies are detected, ensuring that the live environment matches the configurations stored in Git. This approach allows for declarative management of applications, making deployments more efficient and auditable while simplifying the overall process for the team.

# Advantages of ArgoCD

# 1. GitOps Approach
   
Argo CD follows the GitOps methodology, treating Git repositories as the single source of truth for application configurations. This allows for a clear and auditable deployment process, where changes are tracked and managed through Git, enhancing collaboration among teams.

# 2. Continuous Monitoring and Synchronization

Argo CD continuously monitors the state of applications running in Kubernetes and compares it with the desired state defined in Git. If discrepancies are found, it automatically reconciles them, ensuring that the live environment matches the intended configuration.

# 3. Enhanced Visibility

With Argo CD, users gain visibility into the current state of applications and their configurations. The tool provides real-time updates on application health and status, making it easier for teams to track deployments and troubleshoot issues.

# 4. User-Friendly Interface

Argo CD features an intuitive web-based user interface that simplifies the management of applications. Users can easily visualize application states, manage deployments, and access logs, which streamlines the overall workflow.

# 5. Improved Security

By operating within the Kubernetes cluster and pulling changes from Git, Argo CD minimizes the risk of exposing sensitive information. This pull-based mechanism enhances security compared to traditional push-based deployment methods.

# 6. Declarative Configuration Management
   
Argo CD allows users to define the desired state of applications declaratively. This means that infrastructure and application configurations can be managed as code, making it easier to replicate environments and maintain consistency across deployments.

# 7. Scalability

Argo CD can manage multiple Kubernetes clusters from a single control plane, providing a unified view of applications across different environments. This scalability is beneficial for organizations with complex infrastructures.

# 8. Simplified Rollbacks

In case of deployment failures, Argo CD makes it easy to roll back to a previous stable state by reverting to earlier configurations stored in Git, thus minimizing downtime and disruption.
Overall, Argo CD enhances the deployment process for Kubernetes applications, making it more efficient, secure, and manageable for development teams.

# What is Gitops?

GitOps is an operational framework that applies DevOps principles, such as IaC, Pull/Merge requests, version control, and continuous integration/continuous delivery (CI/CD), to infrastructure management. It automates infrastructure provisioning and configuration by using Git repositories as the central source of truth for defining the desired state of systems.

In GitOps, teams utilize configuration files stored in Git, allowing them to manage infrastructure like how they handle application code. This approach enhances the visibility and traceability of changes, making it easier to audit and reproduce issues. By leveraging familiar Git workflows, GitOps empowers developers to take on operational tasks, streamlining the deployment process and improving agility in responding to changes.

GitOps is particularly effective in cloud-native environments, such as those using Kubernetes, where it facilitates continuous deployment and infrastructure management through declarative specifications. Overall, GitOps represents an Infrastructure as Code (IaC) evolution, enabling teams to automate and manage their infrastructure efficiently while maintaining a clear audit trail of all changes.



