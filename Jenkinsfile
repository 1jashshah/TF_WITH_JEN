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
                    // Get the list of available Terraform workspaces
                    def availableWorkspaces = sh(script: 'terraform workspace list | tr -d " *"', returnStdout: true).trim().split('\n')
                    // Define the specific workspaces that have their own variable files
                    def specificWorkspaces = ['developement1', 'ops', 'stage', 'prod']

                    // Iterate through each available workspace
                    for (workspace in availableWorkspaces) {
                        // Select the workspace or create it if it doesn't exist
                        sh "terraform workspace select ${workspace} || terraform workspace new ${workspace}"
                        
                        // Determine the variable file to use
                        def varFile = specificWorkspaces.contains(workspace) ? "${workspace}.tfvars" : "default.tfvars"
                        
                        // Apply the Terraform configuration
                        sh "terraform apply --var-file=${varFile} --auto-approve"
                    }
                }
            }
        }
    }

    post {
        always {
            script {
                // Switch back to the default workspace after the pipeline runs
                sh 'terraform workspace select default'
            }
        }
    }
}
