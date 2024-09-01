pipeline {
    agent any  // Use any available agent

    environment {
        // Define any environment variables here, if needed
        // Example: AWS credentials ID for use with Terraform
        AWS_CREDENTIALS_ID = '339712843218'
    }

    stages {
        stage('Checkout SCM') {
            steps {
                // Checkout code from the repository
                checkout scm
            }
        }

        stage('Terraform Init') {
            steps {
                script {
                    // Initialize Terraform
                    withCredentials([aws(credentialsId: "${env.AWS_CREDENTIALS_ID}", region: 'us-west-1')]) {
                        sh 'terraform init'
                    }
                }
            }
        }

        stage('Terraform Plan') {
            steps {
                script {
                    // Generate Terraform plan
                    withCredentials([aws(credentialsId: "${env.AWS_CREDENTIALS_ID}", region: 'us-east-1')]) {
                        sh 'terraform plan -out=tfplan'
                    }
                }
            }
        }

        stage('Approval') {
            steps {
                input message: 'Approve Terraform Plan?', ok: 'Approve'
            }
        }

        stage('Terraform Apply') {
            steps {
                script {
                    // Apply the Terraform plan with auto-approval
                    withCredentials([aws(credentialsId: "${env.AWS_CREDENTIALS_ID}", region: 'us-west-1')]) {
                        sh 'terraform apply --auto-approve tfplan'
                    }
                }
            }
        }
    }

    post {
        always {
            script {
                // Cleanup workspace or other post-build actions
                echo 'Cleaning up...'
                cleanWs()
            }
        }

        success {
            echo 'Pipeline succeeded!'
        }

        failure {
            echo 'Pipeline failed!'
        }
    }
}
