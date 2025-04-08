pipeline {
    agent any
    environment {
        EC2_IP = credentials('ec2_pub_key')
    }
    stages {
        stage('SSH into EC2') {
            steps {
                sshagent (credentials: ['EC2_SSH_private_Key']) {
                    sh '''
                        ssh -o StrictHostKeyChecking=no ubuntu@$EC2_IP "cd / && ls -al"
                    '''
                }
            }
        }
    }
}
