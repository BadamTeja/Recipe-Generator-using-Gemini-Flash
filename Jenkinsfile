pipeline {
    agent any

    environment {
        IMAGE_NAME = "recipe-generator"
        CONTAINER_NAME = "recipe-app"
        ARTIFACT_NAME = "app.tar.gz"
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

        stage('Test') {
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
                tar --exclude=venv --exclude=.git -czf ${ARTIFACT_NAME} .
                '''
            }
        }

        stage('Archive Artifact') {
            steps {
                archiveArtifacts artifacts: "${ARTIFACT_NAME}", fingerprint: true
            }
        }

        stage('Build Docker Image') {
            steps {
                echo "Building Docker Image..."
                sh "docker build -t ${IMAGE_NAME}:latest ."
            }
        }

        stage('Deploy Container') {
            steps {
                echo "Deploying Container..."
                sh '''
                docker stop ${CONTAINER_NAME} || true
                docker rm ${CONTAINER_NAME} || true
                docker run -d -p 8080:8080 --name ${CONTAINER_NAME} ${IMAGE_NAME}:latest
                '''
            }
        }
    }

    post {
        success {
            echo "✅ Pipeline Success: Artifact + Image + Deployment Done"
        }
        failure {
            echo "❌ Pipeline Failed"
        }
    }
}
