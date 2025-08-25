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
                bat 'terraform destroy -auto-approve'
            }
        }
        
    }
}