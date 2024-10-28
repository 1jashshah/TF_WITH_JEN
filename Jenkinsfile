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
                sh 'terraform init'
            }
        }

        stage('Apply Terraform') {
            steps {
                script {
                    def SWorkspaces = ['developement1', 'ops', 'stage', 'prod']

                    // Iterate over predefined workspaces
                    for (workspace in SWorkspaces) {
                        // Select or create the workspace
                        sh "terraform workspace select ${workspace} || terraform workspace new ${workspace}"
                        
                        // Use the workspace-specific .tfvars file if it exists; otherwise, use "default.tfvars"
                        def varFile = fileExists("${workspace}.tfvars") ? "${workspace}.tfvars" : "default.tfvars"
                        sh "terraform apply --var-file=${varFile} --auto-approve"
                    }
                }
            }
        }
    }

    post {
        always {
            sh 'terraform workspace select default'
        }
    }
}
