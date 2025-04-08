pipeline {
    agent any
    stages {
        stage('Clean Remote Folder') {
            steps {
                sshagent (credentials: ['EC2_SSH_private_Key']) {
                    sh '''
                        ssh -o StrictHostKeyChecking=no ubuntu@$EC2_IP "sudo rm -rf /home/ubuntu/spring-petclinic"
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
}
