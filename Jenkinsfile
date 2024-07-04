pipeline {
   
   environment {
        AWS_ACCESS_KEY_ID     = credentials('AWS_ACCESS_KEY_ID')
        AWS_SECRET_ACCESS_KEY = credentials('AWS_SECRET_ACCESS_KEY')
    }
   
   agent  any
    stages {
        stage('Deploy') {
            steps {
                sh 'pwd; terraform init'
                sh "pwd; terraform plan -out tfplan"
                sh 'pwd; terraform show -no-color tfplan > tfplan.txt'
                sh "pwd; terraform apply tfplan"
            }
        }
        
    }

  }
