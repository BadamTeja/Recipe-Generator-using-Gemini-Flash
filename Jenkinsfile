pipeline {
    agent any

    environment {
        IMAGE_NAME = "recipe-generator"
        CONTAINER_NAME = "recipe-app"
        DOCKERHUB_CREDS = "docker-creds"   // optional
    }

    stages {

        stage('Checkout Code') {
            steps {
                checkout scmGit(
                    branches: [[name: '*/main']],
                    userRemoteConfigs: [[
                        credentialsId: 'git-creds',
                        url: 'https://github.com/BadamTeja/Recipe-Generator-using-Gemini-Flash.git'
                    ]]
                )
            }
        }

        stage('Build Docker Image') {
            steps {
                sh "docker build -t ${IMAGE_NAME}:latest ."
            }
        }

        stage('Stop Old Container') {
            steps {
                sh """
                docker stop ${CONTAINER_NAME} || true
                docker rm ${CONTAINER_NAME} || true
                """
            }
        }

        stage('Run Container') {
            steps {
                sh """
                docker run -d -p 8001:8080 --name ${CONTAINER_NAME} ${IMAGE_NAME}:latest
                """
            }
        }

        // OPTIONAL: Push to DockerHub
        stage('Push to DockerHub') {
            when {
                expression { return false } // change to true if needed
            }
            steps {
                script {
                    docker.withRegistry('', DOCKERHUB_CREDS) {
                        def image = docker.build("${IMAGE_NAME}")
                        image.push('latest')
                    }
                }
            }
        }
    }

    post {
        success {
            echo "Deployment Successful 🚀"
        }
        failure {
            echo "Deployment Failed ❌"
        }
    }
}
