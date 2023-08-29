pipeline {
    environment {
        AWS_ACCESS_KEY_ID     = credentials('awscreds')
        AWS_SECRET_ACCESS_KEY = credentials('awscreds')
    }

   agent  any
    stages {
        stage('checkout') {
            steps {
                 script{
                        dir("terraformvpc")
                        {
                         git branch: 'main', url: 'https://github.com/Akhil-132/terraformvpc.git'
                        }
                    }
                }
            }

        stage('Plan') {
            steps {
                sh 'pwd;cd terraformvpc/ ; terraform init'
                sh "pwd;cd terraformvpc/ ; terraform plan "                
            }
        }
        
        stage('Apply') {
            steps {
                sh "pwd;cd terraformvpc/ ; terraform apply"
            }
        }
    }
}   
