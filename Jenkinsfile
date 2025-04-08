pipeline {
    agent any
    stages {
        stage('Copy to EC2') {
            steps {
                sshagent (credentials: ['EC2_SSH_private_Key']) {
                    sh '''
                        echo "Copying project to EC2..."
                        scp -o StrictHostKeyChecking=no -r . ubuntu@$EC2_IP:/app
                    '''
                }
            }
        }

        stage('SSH into EC2') {
            steps {
                sshagent (credentials: ['EC2_SSH_private_Key']) {
                    sh '''
                        ssh -o StrictHostKeyChecking=no ubuntu@$EC2_IP "cd /apps/spring-petclinic && ./mvnw package && java -jar target/*.jar"
                    '''
                }
            }
        }
    }
}
