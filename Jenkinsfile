pipeline {
    agent any

    environment {
        IMAGE_NAME = "recipe-generator"
        DOCKERHUB_USERNAME = "your_dockerhub_username"
        ARTIFACT_NAME = "app.tar.gz"
        IMAGE_TAG = "${BUILD_NUMBER}"
    }

    stages {

        stage('Checkout') {
            steps {
                checkout scm
            }
        }

        stage('Install Dependencies') {
            steps {
                sh '''
                python3 -m venv venv
                . venv/bin/activate
                pip install --upgrade pip
                pip install -r requirements.txt
                '''
            }
        }

        stage('Tests') {
            steps {
                echo "Running Tests..."
                sh '''
                . venv/bin/activate
                echo "No tests available, skipping"
                '''
            }
        }

        stage('Build Artifact') {
            steps {
                echo "Creating Artifact..."
                sh '''
                tar --exclude=venv --exclude=.git --warning=no-file-changed -czf ${ARTIFACT_NAME} .
                '''
            }
        }

        stage('Archive Artifact') {
            steps {
                archiveArtifacts artifacts: "${ARTIFACT_NAME}", fingerprint: true
            }
        }

        stage('Docker Login') {
            steps {
                withCredentials([usernamePassword(
                    credentialsId: 'docker-creds',
                    usernameVariable: 'DOCKER_USER',
                    passwordVariable: 'DOCKER_PASS'
                )]) {
                    sh 'echo $DOCKER_PASS | docker login -u $DOCKER_USER --password-stdin'
                }
            }
        }

        stage('Build Docker Image') {
            steps {
                echo "Building Docker Image..."
                sh '''
                docker build -t ${DOCKERHUB_USERNAME}/${IMAGE_NAME}:${IMAGE_TAG} .
                docker tag ${DOCKERHUB_USERNAME}/${IMAGE_NAME}:${IMAGE_TAG} ${DOCKERHUB_USERNAME}/${IMAGE_NAME}:latest
                '''
            }
        }

        stage('Push Docker Image') {
            steps {
                echo "Pushing Docker Images..."
                sh '''
                docker push ${DOCKERHUB_USERNAME}/${IMAGE_NAME}:${IMAGE_TAG}
                docker push ${DOCKERHUB_USERNAME}/${IMAGE_NAME}:latest
                '''
            }
        }
    }

    post {
        success {
            echo "✅ Docker Image Built & Pushed Successfully"
        }
        failure {
            echo "❌ Pipeline Failed"
        }
    }
}
