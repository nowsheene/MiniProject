pipeline {
   
   environment {
        AWS_ACCESS_KEY_ID     = credentials('AWS_ACCESS_KEY_ID')
        AWS_SECRET_ACCESS_KEY = credentials('AWS_SECRET_ACCESS_KEY')
    }
   
   agent  any
    stages {
       stage('clone') {
            steps {
                 script{
                        dir("terraform")
                        {
                            git branch: 'main',
                              url: "https://github.com/nowsheene/MiniProject.git"
                        }
                    }
                }
            }

        stage('Deploy') {
            steps {
                sh 'pwd; terraform init'
                sh 'pwd; terraform plan'
                sh "pwd; terraform apply -auto-approve"
            }
        }
        
    }

  }
