pipeline {
    agent any

    environment {
        IMAGE_NAME = "recipe-generator"
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

        stage('Docker Login, Build & Push') {
            steps {
                echo "Docker Login, Build & Push..."
                withCredentials([usernamePassword(
                    credentialsId: 'docker-creds',
                    usernameVariable: 'DOCKER_USER',
                    passwordVariable: 'DOCKER_PASS'
                )]) {
                    sh '''
                    echo $DOCKER_PASS | docker login -u $DOCKER_USER --password-stdin

                    docker build -t $DOCKER_USER/${IMAGE_NAME}:${IMAGE_TAG} .
                    docker tag $DOCKER_USER/${IMAGE_NAME}:${IMAGE_TAG} $DOCKER_USER/${IMAGE_NAME}:latest

                    docker push $DOCKER_USER/${IMAGE_NAME}:${IMAGE_TAG}
                    docker push $DOCKER_USER/${IMAGE_NAME}:latest

                    echo "Cleaning old local images..."

                    docker rmi $DOCKER_USER/${IMAGE_NAME}:${IMAGE_TAG} || true
                    docker image prune -f
                    '''
                }
            }
        }
    }

    post {
        success {
            echo "✅ Docker Image Built, Pushed & Local Cleanup Done"
        }
        failure {
            echo "❌ Pipeline Failed"
        }
    }
}
