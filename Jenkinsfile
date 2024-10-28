pipeline {
    agent any
    environment {
        AWS_ACCESS_KEY_ID     = credentials('MY-AWS')
        AWS_SECRET_ACCESS_KEY = credentials('MY-AWS')
        AWS_REGION = "ap-south-1"
    }
    stages {
        stage('Git Checkout') {
            steps {
                git url: 'https://github.com/1jashshah/TF_WITH_JEN.git', branch: 'main', credentialsId: 'gitid'
            }
        }
        stage('Initialize Terraform') {
            steps {
                script {
                    sh 'terraform init'
                }
            }
        }
        stage('Apply Terraform for All Workspaces') {
            steps {
                script {
                    def availableWorkspaces = sh(script: 'terraform workspace list | tr -d " *"', returnStdout: true).trim().split('\n')
                    def specificWorkspaces = ['developement1', 'ops', 'stage', 'prod']

                    for (workspace in availableWorkspaces) {
                        sh "terraform workspace select ${workspace} || terraform workspace new ${workspace}"
                        def varFile = specificWorkspaces.contains(workspace) ? "${workspace}.tfvars" : "default.tfvars"
                        sh "terraform apply --var-file=${varFile} --auto-approve"
                    }
                }
            }
        }
    }

    post {
        always {
            script {
                sh 'terraform workspace select default'
            }
        }
    }
}
