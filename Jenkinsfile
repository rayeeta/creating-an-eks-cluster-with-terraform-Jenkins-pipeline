
pipeline {

    parameters {
        booleanParam(name: 'autoApprove', defaultValue: false, description: 'Automatically run apply after generating plan?')
    } 
    environment {
        AWS_ACCESS_KEY_ID     = credentials('AWS_ACCESS_KEY_ID')
        AWS_SECRET_ACCESS_KEY = credentials('AWS_SECRET_ACCESS_KEY')
    }

    agent any

    stages {
        stage('Checkout') {
            steps {
                script {
                    echo 'Checking out code from Git repository...'
                    dir("terraform") {
                        git branch: 'main', url: 'https://github.com/rayeeta/eks-terraform-jenkins-pipeline.git'
                    }
                }
            }
        }

        stage('Terraform Init') {
            steps {
                echo 'Initializing Terraform...'
                dir("terraform") {
                    sh 'terraform init'
                }
            }
        }

        stage('Terraform Validate') {
            steps {
                echo 'Validating Terraform configuration...'
                dir("terraform") {
                    sh 'terraform validate'
                }
            }
        }

        stage('Terraform Plan') {
            steps {
                echo 'Generating Terraform plan...'
                dir("terraform") {
                    sh 'terraform plan -out=tfplan'
                }
            }
        }

        stage('Terraform Apply') {
            when {
                expression {
                    return params.autoApprove
                }
            }
            steps {
                echo 'Applying Terraform plan...'
                dir("terraform") {
                    withCredentials([[$class: 'AmazonWebServicesCredentialsBinding', credentialsId: "${AWS_CREDENTIALS_ID}"]]) {
                        sh 'terraform apply -auto-approve tfplan'
                    }
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
            echo 'Cleaning up workspace...'
            cleanWs()
        }
    }
}
