## Let's break down each step in more detail to ensure you can follow along and get everything set up correctly.

### Detailed Step-by-Step Guide

#### Tools to integrate with Jenkins:
    1- GitHub with Jenkins
    2- Terraform with Jenkins


### 1- Integrate your local environment with a GitHub account by generating a public and private key. 
        ssh-keygen. cat the public key and paste it in the GitHub profile settings-ssh&GPG keys--> New ssh key and
        paste the public key in the box. This way you have set the configuration of the github account and
        your local environment.
    2-  Integrating Jenkins UI with GitHub by Generating Personal Access Token phase 1: 
        Go the GitHub UI and click on profile settings-Developers settings--> Personal Access Token Tokens (Classic)-->
        Generate new token (classic)--> Give a name and select the scopes needed for the project you or your team will 
        want GitHub to do. Copy the token and head over to the next stage.
    3-  Integrating Jenkins env with the Personal-Access-Token phase 2: 
        In the Jenkins UI, head to Manage Jenkins--> System(Configure global systems and paths)--> Scroll down to the 
        GitHub section-GitHub server--> Give it a name, API URL stays the same--> Credentials--> Add-Jenkins--> 
        Kind(select: Secret Text)--> UserName(Give it a name)--> Password(make sure to paste the Personal Access Token created from Github)-->
        ID(give the token a name)--> ADD and quit--> +ADD dropdown section select the name of the token you gave at signup-Run Test Connection--> 
        Apply and Save.
    4-  Hosting the PRIVATE key from ssh-keygen phase 3: Cat the private key and copy its entire content and head to the Jenkins UI-->
        Manage Jenkins--> Security--> Credentials--> Global--> Add Credentials--> Kind(SSH username with private key)> ID(give it a name of your choice)-->
        Private Key(check the box)-Add-Paste the private key in the box-Ok and quit.

# Back to Dashboard, New item-name the project(e.g Test job)--> Free Style Project--> Ok-Source Code Management section--> Select Git-->
# head to the GitHub repo--> Code(the green button)--> SSH--> Copy the link-head to Jenkins UI--> Credentials(select the private key username that was just created--> Branches to build section(main)--> Build Triggers(check: GitHub hook trigger for GITScm polling)--> Post--> build Actions--> Add post--> build action(Set GitHub commit status (universal))--> select: What-One of the defaults messages and statuses.


# Last integration: Go to the GitHub repository--> Settings--> webhooks--> Add Webhook--> Payload URL section(paste the url of the Jenkins 
UI ending with 8080/ and add the endpoint for Jenkins with (GitHub-webhook)). I has to look something like this (http://54.205.66.23:8080/github-webhook/)-->
Content Type(application json)--> which events will like to trigger this webhook: select Just the push event--> check Active--> Add Webhook


#### 1. *Install Jenkins and Required Plugins*

1. *Jenkins Installation*:
   - *On Ubuntu*: Follow the documentation on the Jenkins website below
     https://www.jenkins.io/doc/book/installing/linux/#debianubuntu
     
   - Access Jenkins at http://<your-server-ip>:8080.

2. *Initial Jenkins Setup*:
   - Retrieve the initial admin password:
     sh
     sudo cat /var/lib/Jenkins/secrets/initialAdminPassword
     
   - Open Jenkins in a web browser, use the retrieved password for setup, and install suggested plugins.

3. *Install Required Plugins*:
   - Go to *Manage Jenkins* -> *Manage Plugins* -> *Available*.

   - Search and install the following plugins:
     - *GitHub Plugin*
     - *Pipeline Plugin*
     - *Terraform Plugin*
     - *Snyk Security Plugin*

#### 2. *Configure GitHub Integration*

1. *Create a GitHub Repository*:
   - Log in to GitHub and create a new repository for your Terraform code.

2. *Generate GitHub Personal Access Token*:
   - Go to *GitHub* -> *Settings* -> *Developer settings* -> *Personal access tokens* -> *Generate new token*.
   - Select the repo and admin:repo_hook scopes.
   - Generate the token and copy it.

3. *Add GitHub Credentials to Jenkins*:
   - Go to *Jenkins Dashboard* -> *Manage Jenkins* -> *Manage Credentials* -> (select domain) -> *Add Credentials*.
   - Choose Secret text for the kind, paste the GitHub token, and give it an ID (e.g., GitHub-token).

#### 3. *Set Up AWS Credentials in Jenkins*

1. *Create AWS IAM User*:
   - Go to *AWS Management Console* -> *IAM* -> *Users* -> *Add user*.
   - Select Programmatic access.
   - Attach Administrator Access policy or a custom policy with necessary permissions.
   - Save the Access Key ID and Secret Access Key.

2. *Add AWS Credentials to Jenkins*:
   - Go to *Jenkins Dashboard* -> *Manage Jenkins* -> *Manage Credentials* -> (select domain) -> *Add Credentials*.
   - Choose AWS Credentials for kind, enter the Access Key ID and Secret Access Key, and give it an ID (e.g., aws-credentials).

#### 4. *Write Terraform Code*

1. *Create Terraform Scripts*:
   - Create a directory for your Terraform

2. *Push the Code to GitHub*:
   - Initialize a Git repository, commit the files, and push to GitHub:

  
   git init
   git add .
   git commit -m "Initial commit"
   git remote add origin https://github.com/<your-username>/<your-repo>.git
   git push -u origin master
   

#### 5. *Set Up Snyk Integration*

1. *Obtain Snyk API Token*:
   - Go to *Snyk* -> *Account Settings* -> *API Token*.
   - Copy the API token.

2. *Add Snyk API Token to Jenkins*:
   - Go to *Jenkins Dashboard* -> *Manage Jenkins* -> *Manage Credentials* -> (select domain) -> 
     *Add Credentials*.
   - Choose Secret text for kind, paste the Snyk API token, and give it an ID (e.g., snyk-token).

#### 6. *Create Jenkins Pipeline*

1. *Create a New Pipeline Job*:
   - Go to *Jenkins Dashboard* -> *New Item* -> *Pipeline*.
   - Enter a name for the job and select Pipeline as the type.

2. *Pipeline Script*:
   - Use the following example pipeline script:

    'Pipeline script found above'
   
   - Replace <your-username> and <your-repo> with your GitHub username and repository name.

#### 7. *Trigger and Monitor the Pipeline*

1. *Trigger the Pipeline*:
   - Manually trigger the pipeline from the Jenkins Dashboard by clicking on the pipeline job and selecting *Build Now*.

2. *Set Up GitHub Webhooks*:
   - Go to your GitHub repository -> *Settings* -> *Webhooks* -> *Add webhook*.
   - Enter the Jenkins URL with /GitHub-webhook/ at the end (e.g., http://<your-jenkins-url>/github-webhook/).
   - Choose application/json as the content type and add the webhook.
   - This will automatically trigger the Jenkins pipeline on code commits.

3. *Monitor the Pipeline*:
   - Monitor the pipeline execution in Jenkins. You can see the progress and logs for each stage.
   - Check the console output for logs and results of each stage.

By following these detailed steps, you should be able to set up a Jenkins CI/CD pipeline that integrates 
Terraform, GitHub, AWS, and Snyk for infrastructure as code. This setup ensures automated deployments, 
security scans, and consistent infrastructure management.
