## Let's break down each step in more detail to ensure you can follow along and get everything set up correctly.

### Detailed Step-by-Step Guide.

#### Tools to integrate with Jenkins:
    1- GitHub with Jenkins
    2- Terraform with Jenkins
    3- AWS with Jenkins

###    Create an EC2-instance in AWS, and install Jenkins/Java, and Terraform in the running server:

        Jenkins installation: https://www.jenkins.io/doc/book/installing/linux/#debianubuntu
        Terraform installation: https://developer.hashicorp.com/terraform/install
        
###    Install AWS CLI

###     Download the AWS CLI version 2 installer:

        curl "https://awscli.amazonaws.com/awscli-exe-linux-x86_64.zip" -o "awscliv2.zip"
        
###     Unzip the downloaded package:

        sudo apt install unzip -y
        unzip awscliv2.zip

###     Run the installer:

        sudo ./aws/install

###     Verify the installation:

        aws --version

###    1- Integrate your local environment with a GitHub account by generating a public key. 
        ssh-keygen. cat the public key and paste it in the GitHub profile settings--> ssh&GPG keys--> 
        New ssh key and paste the public key in the box. This way you have set the configuration of the 
        Github account and your local environment.

###    2-  Sign in to the Jenkins UI to access the Jenkins dashboard: 

        Browse to http://localhost:8080 e.g(18.144.61.150:8080 hit ENTER) (or whichever port you configured 
        for Jenkins when installing it) and wait until the Unlock Jenkins page appears. Sudo cat             
        /var/lib/jenkins/secrets/initialAdminPassword, use the key in the Jenkins UI and walkthrough
        with the installation to the end.        
        
###    3-  Integrating Jenkins UI with GitHub by Generating Personal Access Token:
    
        Go to the GitHub UI and click on profile settings--> Developers settings--> Personal Access Token Tokens (Classic)-->
        Generate a new token (classic)--> Give a name and select the scopes needed for the project you or your team  
        want GitHub to do. Copy the token and head over to the next stage.

###    4-  Integrating Jenkins env with the Personal-Access-Token: 

        In the Jenkins UI, head to Manage Jenkins--> System(Configure global systems and paths)--> Scroll down to the 
        GitHub section-GitHub server--> Give it a name, API URL stays the same--> Credentials--> Add-Jenkins--> 
        Kind(select: Secret Text)--> UserName(Give it a name)--> Password(make sure to paste the 
        Personal Access Token created from Github)--> ID(give the token a name)--> ADD and quit--> +ADD dropdown 
        select the name of the token you gave at signup-Run Test Connection--> Apply and Save.
        
        
###    5-  Hosting the PRIVATE key from ssh-keygen: 
        Cat the private key and copy its entire content then head to the Jenkins dashboard--> 
        Manage Jenkins--> Security--> Credentials--> Global--> Add Credentials--> Kind(SSH username 
        with private key)> ID(give it a name of your choice)--> Private Key(check the box)--> Add-Paste the private key 
        in the box--> Ok and quit.

###    6-  AWS and Jenkins Integration:
Create a user in AWS IAM ==> attach ==> Next==> Attach policies directly==> Next==> 
Create User.
# Go to Users: 
Click on the user==> Security credentials==> Create Access Key==> Command Line Interface (CLI)
Confirmation==> Next==> Create Access Key==> Copy the Access key and 
Secret access key(to use later in the pipeline job)


##      Verify AWS Credentials in Jenkins
# Login to Jenkins Dashboard:

Open your Jenkins instance in a web browser.

# Go to the Jenkins dashboard:
Click on "Manage Jenkins" from the sidebar.
# Access Credentials:

Click on "Manage Credentials" or "Credentials" depending on your Jenkins version.
# Check AWS Credentials:

Ensure that the AWS credentials with Account ID 339712843218 exist in the appropriate domain 
(global or specific domain).

If the credentials do not exist, you will need to create them:

Click on the domain (e.g., (global) if it's a global credential).
Click on "Add Credentials" (typically found on the left sidebar).
Fill in the AWS Credentials:

# Kind: Choose "AWS Credentials".

# Access Key ID: Enter your AWS Access Key ID.

# Secret Access Key: Enter your AWS Secret Access Key.

# ID: Enter 339712843218 or another unique ID (make sure it matches the ID used in your Jenkinsfile).

# Description: Optionally, provide a description for the credentials.

# Click "OK" to save.
        
#       To install plugins:

        Go to Manage Jenkins > Manage Plugins.
        Click on the Available tab.
        Search for the desired plugin (e.g., "AWS Steps").
        Check the box next to the plugin and click Install without restart.
        Configure AWS Credentials in Jenkins
        Jenkins needs credentials to authenticate with AWS. You can set up these 
        credentials in Jenkins using IAM (Identity and Access Management) roles or user credentials.

##      Using AWS IAM User Credentials:

#       Create an IAM User in AWS:

        Go to the AWS Management Console.
        Navigate to IAM > Users > Add user.
        Provide a username and select "Programmatic access".
        Attach the necessary policies or permissions.
        Add AWS Credentials to Jenkins:

#       Go to Manage Jenkins > Manage Credentials.
        Select the appropriate domain (e.g., (global)).
        Click on Add Credentials.
        Choose Amazon Web Services Credentials as the kind.
        Enter your Access Key ID and Secret Access Key obtained from AWS IAM.
        Provide an ID and description for easy reference.
        Configure AWS CLI (Optional)

##      If you plan to use AWS CLI commands in your Jenkins pipelines or jobs:

#       Install AWS CLI on Jenkins Server:

        Follow the AWS CLI installation instructions for your operating system: 
        AWS CLI Installation Guide.
        Configure AWS CLI:

        Run aws configure on your Jenkins server to set up AWS credentials.
        This step is optional if you are using the Jenkins AWS plugins for interactions.

##      Set Up Jenkins Pipeline or Freestyle Project
        Integrate AWS services into your Jenkins pipeline or freestyle project.

#       For Jenkins Pipeline:

        Use AWS Plugin Steps:

        Include AWS-specific steps in your Jenkinsfile to interact with AWS services.        



# Back to Jenkins Dashboard:

    New item-name the project(e.g Test job)--> Free Style Project--> Ok--> Source Code Management
    section--> Select Git--> head to the GitHub repo--> Code(the green button)--> SSH--> Copy the link-head 
    to Jenkins UI--> Credentials(select the private key username that was just created--> 
    Branches to build section(main)--> Build Triggers(check: GitHub hook trigger for GITScm polling)--> Post--> 
    build Actions--> Add post--> build action(Set GitHub commit status (Universal))--> 
    Select: What-One of the Defaults messages and Statuses.


# Last integration: 

    Go to the GitHub repository--> Settings--> webhooks--> Add Webhook--> Payload URL section(paste the URL of the Jenkins 
    UI ending with 8080/ and add the endpoint for Jenkins with (GitHub-webhook)). It has to look something like this             
    (http://54.205.66.23:8080/github-webhook/)--> Content Type(application json)--> which events will like to trigger this webhook: 
    select Just the push event--> check Active--> Add Webhook


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
