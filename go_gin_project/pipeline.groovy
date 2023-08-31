pipeline {
    agent any
    tools {
        go '1.21.0'
    }
    stages {
        stage('Checkout') {
            steps {
                // Checkout the code from the GitHub master branch
                checkout scm
            }
        }
        stage('compile') {
                    steps {
                        // Run Go tests
                        dir("${env.WORKSPACE}/go_gin_project"){
                            sh 'go mod tidy'
                        }

                    }
                }
        stage('Test') {
            steps {
                // Run Go tests
                dir("${env.WORKSPACE}/go_gin_project"){
                   sh 'go test ./...'
                }

            }
        }

        stage('Build') {
            steps {
                // Run Go build
                dir("${env.WORKSPACE}/go_gin_project/cmd"){
                   sh 'go build -o myapp'
                }
            }
        }
//         stage('deploy') {
//                     steps {
//                         script {
//                             // scp file and ssh on server, run app
//                         }
//                     }
//         }
    }

        post {
        always {
            // Clean up artifacts or perform any other necessary actions
            deleteDir()
        }
    }
}
