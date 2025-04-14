pipeline {
    agent any

    environment {
        IMAGE_NAME = "spring-petclinic"
        CONTAINER_NAME = "petclinic"
        REMOTE_USER = "ubuntu"
        REMOTE_HOST = "EC2_IP"
    }

    stages {
        stage('Clone') {
            steps {
                git 'https://github.com/spring-projects/spring-petclinic.git'
            }
        }

        stage('Build Docker Image') {
            steps {
                script {
                    docker.build(IMAGE_NAME)
                }
            }
        }

        stage('Save Docker Image') {
            steps {
                sh "docker save -o petclinic.tar ${IMAGE_NAME}"
            }
        }

        stage('Copy Image to EC2') {
            steps {
                sshagent(credentials: ['EC2_SSH_private_Key']) {
                    sh "scp petclinic.tar ${REMOTE_USER}@${REMOTE_HOST}:/home/ubuntu/"
                }
            }
        }

        stage('Load and Run on EC2') {
            steps {
                sshagent(credentials: ['pipeline {
    agent any
    stages {
        stage('Clean Remote Folder') {
            steps {
                sshagent (credentials: ['EC2_SSH_private_Key']) {
                    sh '''
                        ssh -o StrictHostKeyChecking=no ubuntu@$EC2_IP "sudo rm -rf /home/ubuntu/spring-petclinic && sudo rm -rf /app/spring-petclinic"
                    '''
                }
            }
        }

        stage('Copy to EC2') {
            steps {
                sshagent (credentials: ['EC2_SSH_private_Key']) {
                    sh '''
                        echo "Copying project to EC2..."
                        scp -o StrictHostKeyChecking=no -r . ubuntu@$EC2_IP:/home/ubuntu/spring-petclinic
                    '''
                }
            }
        }
        
        stage('SSH into EC2') {
            steps {
                sshagent (credentials: ['EC2_SSH_private_Key']) {
                    sh '''
                        ssh -o StrictHostKeyChecking=no ubuntu@$EC2_IP "sudo mv /home/ubuntu/spring-petclinic /app/spring-petclinic && cd /app/spring-petclinic && ./mvnw package && java -jar target/*.jar"
                    '''
                }
            }
        }
    }
}']) {
                    sh """
                    ssh ${REMOTE_USER}@${REMOTE_HOST} '
                        docker stop ${CONTAINER_NAME} || true &&
                        docker rm ${CONTAINER_NAME} || true &&
                        docker load -i petclinic.tar &&
                        docker run -d -p 8080:8080 --name ${CONTAINER_NAME} ${IMAGE_NAME}
                    '
                    """
                }
            }
        }
    }
}
