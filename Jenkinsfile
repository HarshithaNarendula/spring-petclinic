pipeline {
    agent any
    stages {
        stage('SSH into EC2') {
            steps {
                sshagent (credentials: ['EC2_SSH_private_Key']) {
                    sh '''
                        ssh -o StrictHostKeyChecking=no ubuntu@$EC2_IP "cd spring-petclinic && ./mvnw package && java -jar target/*.jar"
                    '''
                }
            }
        }
    }
}
