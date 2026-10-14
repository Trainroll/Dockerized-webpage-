
pipeline {
    agent any

    environment {
        IMAGE_NAME = "bolarinwar/docker-web-lab"
    }

    stages {
        stage('Checkout') {
            steps {
                checkout scm
            }
        }

        stage('Build Docker Image') {
            steps {
                sh 'docker build -t $IMAGE_NAME:$BUILD_NUMBER .'
            }
        }

        stage('Test Docker Image') {
            steps {
                sh 'docker image inspect $IMAGE_NAME:$BUILD_NUMBER'
            }
        }

        stage('Push to Docker Hub') {
            steps {
                withCredentials([usernamePassword(
                    credentialsId: 'dockerhub-creds',
                    usernameVariable: 'DOCKERHUB_USER',
                    passwordVariable: 'DOCKERHUB_TOKEN'
                )]) {
                    sh '''
                        echo "$DOCKERHUB_TOKEN" | docker login \
                          --username "$DOCKERHUB_USER" \
                          --password-stdin

                        docker push "$IMAGE_NAME:$BUILD_NUMBER"
                        docker tag "$IMAGE_NAME:$BUILD_NUMBER" "$IMAGE_NAME:latest"
                        docker push "$IMAGE_NAME:latest"
                        docker logout
                    '''
                }
            }
        }
    }
}
