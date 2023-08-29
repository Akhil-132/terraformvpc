pipeline {

    parameters {
        booleanParam(name: 'autoApprove', defaultValue: false, description: 'Automatically run apply after generating plan?')
    } 
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
                sh "pwd;cd terraformvpc/ ; terraform plan -out tfplan"
                sh 'pwd;cd terraformvpc/ ; terraform show -no-color tfplan > tfplan.txt'
            }
        }
        stage('Approval') {
           when {
               not {
                   equals expected: true, actual: params.autoApprove
               }
           }

           steps {
               script {
                    def plan = readFile 'terraform/tfplan.txt'
                    input message: "Do you want to apply the plan?",
                    parameters: [text(name: 'Plan', description: 'Please review the plan', defaultValue: plan)]
               }
           }
       }

        stage('Apply') {
            steps {
                sh "pwd;cd terraform/ ; terraform apply -input=false tfplan"
            }
        }
    }

  }
