pipeline {

   agent  any
    stages {
        stage('Deploy') {
            steps {
                sh 'pwd'
                sh 'pwd;cd terraform/ ; terraform init'
                sh "pwd;cd terraform/ ; terraform plan -out tfplan"
                sh 'pwd;cd terraform/ ; terraform show -no-color tfplan > tfplan.txt'
                sh "pwd;cd terraform/ ; terraform apply tfplan"
            }
        }
        
    }

  }
