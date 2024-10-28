pipeline {
    agent any
    environment {
        AWS_ACCESS_KEY_ID     = credentials('MY-AWS')
        AWS_SECRET_ACCESS_KEY = credentials('MY-AWS')
        AWS_REGION = "ap-south-1"
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
                }
            }
        }
        stage('Apply Terraform for All Workspaces') {
            steps {
                script {
                    def workspaces = ['developement1', 'ops', 'stage', 'prod']
                    
                    for (workspace in workspaces) {              
                        sh "terraform select ${workspace} || terraform workspace new ${workspace}"
                        sh "terraform workspace select ${workspace}"
                        sh "terraform apply --var-file=${workspace}.tfvars --auto-approve"
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
