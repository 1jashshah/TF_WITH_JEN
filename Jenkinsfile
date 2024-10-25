pipeline {
    agent any
    environment {
        TF_WORKSPACE = ''
    }
    stages {
        stage('git-checkout'){
            steps{
                git url: 'https://github.com/1jashshah/TF_WITH_JEN.git', branch: 'main', credentialsId: 'gitid'
            }
        }
        stage('Initialize Terraform') {
            steps {
                script {
                 
                    sh 'terraform init'
                    sh  'terraform plan'
                }
            }
        }
        stage('Apply Terraform for All Workspaces') {
            steps {
                script {
                    def workspaces = ['dev', 'ops', 'stage', 'prod']
                    
                    for (workspace in workspaces) {
                        TF_WORKSPACE = workspace
                        
                        sh "terraform workspace new ${workspace} "
                        sh "terraform workspace select ${workspace}"
                        sh "terraform apply -var-file=${workspace} .tfvars --auto-approve"
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
