pipeline {

   agent  any
    stages {
        stage('clone') {
            steps {
                 script{
                        dir("terraform")
                        {
                            cd terraform/
                            git "https://github.com/yeshwanthlm/Terraform-Jenkins.git"
                        }
                    }
                }
            }
          
        stage('Deploy') {
            steps {
                sh 'pwd;cd terraform/ ; terraform init'
                sh "pwd;cd terraform/ ; terraform plan -out tfplan"
                sh 'pwd;cd terraform/ ; terraform show -no-color tfplan > tfplan.txt'
                sh "pwd;cd terraform/ ; terraform apply tfplan"
            }
        }
        
    }

  }
