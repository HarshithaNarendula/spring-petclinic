pipeline {
    agent any

    environment {
        IMAGE_NAME = "spring-petclinic"
        CONTAINER_NAME = "petclinic"
    }

    stages {
        stage('Clean Remote Folder') {
            steps {
                sshagent (credentials: ['EC2_SSH_private_Key']) {
                    sh '''
                        echo "Cleaning remote folder..."
                        ssh -o StrictHostKeyChecking=no ubuntu@$EC2_IP
                            sudo docker stop petclinic || true &&
                            sudo docker rm petclinic || true &&
                            sudo rm -rf /home/ubuntu/spring-petclinic &&
                            sudo rm -rf /app/spring-petclinic
                        "
                    '''
                }
            }
        }

        stage('Copy Project to EC2') {
            steps {
                sshagent (credentials: ['EC2_SSH_private_Key']) {
                    sh '''
                        echo "Copying project to EC2..."
                        scp -o StrictHostKeyChecking=no -r . ubuntu@$EC2_IP:/home/ubuntu/spring-petclinic
                    '''
                }
            }
        }

        stage('Build and Run App on EC2 (Dockerized)') {
            steps {
                sshagent (credentials: ['EC2_SSH_private_Key']) {
                    sh '''
                        ssh -o StrictHostKeyChecking=no ubuntu@$EC2_IP "
                            sudo mv /home/ubuntu/spring-petclinic /app/spring-petclinic &&
                            cd /app/spring-petclinic &&
                            ./mvnw package &&
                            sudo docker build -t spring-petclinic . &&
                            sudo docker run -d -p 8080:8080 --name petclinic spring-petclinic
                        "
                    '''
                }
            }
        }
    }
}
