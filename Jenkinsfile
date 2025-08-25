pipeline{
    agent any
    tools{
        terraform 'terraform'
    }
    environment {
        AWS_ACCESS_KEY_ID=credentials('aws_access_credentials')
        AWS_SECRET_ACCESS_KEY=credentials("aws_access_credentials")
    }
    stages{
        stage("Git checkout"){
            steps{
                git branch: 'main', url: 'https://github.com/ajaygaddam91/terraform-project.git'
            }
        }
        stage("Terraform initialization"){
            steps{
                bat 'terraform init'
            }
        }
        stage("Terraform plan"){
            steps{
                bat 'terraform plan'
            }
        }
        stage("terraform apply"){
            steps{
                withCredentials([sshUserPrivateKey(credentialsId: 'ubuntu-demo', keyFileVariable: 'SSH_KEY', usernameVariable: 'SSH_USER')]) {
          bat '''
            set TF_VAR_ssh_user=%SSH_USER%
            set TF_VAR_private_key_path=%SSH_KEY%
            terraform apply -auto-approve
          '''
            }
        }
        
    }
}