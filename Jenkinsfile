pipeline {

    parameters {
        booleanParam(name: 'autoApprove', defaultValue: false, description: 'Automatically run apply after generating plan?')
    } 
    environment {
        AWS_ACCESS_KEY_ID     = credentials('AWS_ACCESS_KEY_ID')
        AWS_SECRET_ACCESS_KEY = credentials('AWS_SECRET_ACCESS_KEY')
    }

   agent  any
    stages {
        stage('checkout') {
            steps {
                 script{
                        dir("terraform")
                        {
                            git "https://github.com/rayeeta/eks-terraform-jenkins-pipeline.git"
                        }
                    }
                }
            }
stage('Terraform Init') {
            steps {
                // Initialize Terraform
                sh 'terraform init'
            }
        }

        stage('Terraform Validate') {
            steps {
                // Validate the Terraform configuration
                sh 'terraform validate'
            }
        }

        stage('Terraform Plan') {
            steps {
                // Generate and display the Terraform execution plan
                sh 'terraform plan'
            }
        }

        stage('Terraform Apply') {
            steps {
                // Automatically apply the Terraform plan without manual approval
                withCredentials([[$class: 'AmazonWebServicesCredentialsBinding', credentialsId: "${AWS_CREDENTIALS_ID}"]]) {
                    sh 'terraform apply -auto-approve'
                }
            }
        }
    }

    post {
        success {
            echo 'Infrastructure successfully applied.'
        }
        failure {
            echo 'Infrastructure application failed.'
        }
        always {
            // Clean up the workspace after the build completes
            cleanWs()
        }
    }
}
