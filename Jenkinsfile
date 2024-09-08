pipeline {
    agent any  // Use any available agent

    environment {
        // Define AWS credentials and environment variables
        AWS_CREDENTIALS_ID = '339712843218'
        
        // Set this to 'true' to destroy the resources
        DESTROY_RESOURCES = 'true'
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

        stage('Terraform Destroy') {
            steps {
                script {
                    // Always run Terraform destroy as DESTROY_RESOURCES is set to true
                    withCredentials([aws(credentialsId: "${env.AWS_CREDENTIALS_ID}", region: 'us-west-1')]) {
                        echo "Destroying all resources..."
                        sh 'terraform destroy --auto-approve'
                    }
                }
            }
        }
    }

    post {
        always {
            script {
                // Cleanup workspace or other post-build actions
                echo 'Cleaning up workspace...'
                cleanWs()
            }
        }

        success {
            echo 'Pipeline succeeded! Resources have been destroyed.'
        }

        failure {
            echo 'Pipeline failed! Check logs for more details.'
        }
    }
}
