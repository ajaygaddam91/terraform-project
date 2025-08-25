pipeline{
    agent any
    parameters{
        choice(name:'CHOICE',choices:['init','validate','fmt','plan','apply -auto-approve','destroy -auto-approve'],description: 'Select terraform workflow')
    }
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
        stage("terraform ${params.CHOICE}"){
            steps{
                withCredentials([sshUserPrivateKey(credentialsId: 'ubuntu-demo', keyFileVariable: 'SSH_KEY', usernameVariable: 'SSH_USER')]) {
          bat """
            set TF_VAR_ssh_user=%SSH_USER%
            set TF_VAR_private_key=%SSH_KEY%
            terraform ${params.CHOICE}
          """
            }
        }        
      }
   }
}
