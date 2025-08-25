pipeline{
    agent any
    tools{
        terraform 'terraform'
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
                bat 'terraform apply -auto-approve'
            }
        }
        
    }
}