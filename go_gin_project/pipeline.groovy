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

        stage('Test') {
            steps {
                // Run Go tests
                sh 'cd go_gin_project/'
                sh 'ls'
                sh 'go test ./...'
            }
        }

        stage('Build') {
            steps {
                // Run Go build
                sh 'cd go_gin_project/'
                sh 'go build -o myapp'
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