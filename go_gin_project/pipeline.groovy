pipeline {
    agent any

    stages {
        stage('Checkout') {
            steps {
                // Checkout the code from the GitHub master branch
                checkout scm
            }
        }

        stage('Test') {
            steps {
                // Run Go tests
                sh 'go test ./...'
            }
        }

        stage('Build') {
            steps {
                // Run Go build
                sh 'go build -o myapp'
            }
        }

        stage('Deploy') {
            steps {
                // Deploy the application (replace with your deployment command)
                sh 'YOUR_DEPLOY_COMMAND'
            }
        }
    }

    post {
        always {
            // Clean up artifacts or perform any other necessary actions
            deleteDir()
        }
    }
}
