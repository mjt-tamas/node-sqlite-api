pipeline {
    agent any

    stages {
        stage('Checkout') {
            steps {
                checkout scm
            }
        }

        stage('Build Docker Image') {
            steps {
                script {
                    sh 'docker build -t node-sqlite-api:latest .'
                }
            }
        }

        stage('Deploy') {
            steps {
                script {
                    // Stop and remove the old container if it exists
                    sh 'docker stop api-container || true'
                    sh 'docker rm api-container || true'
                    
                    // Run the new container on port 3000
                    sh 'docker run -d --name api-container -p 3000:3000 node-sqlite-api:latest'
                }
            }
        }
    }
}