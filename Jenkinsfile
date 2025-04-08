pipeline {
    agent any
    stages {
        stage('Deploy') {
            steps {
                sshagent (credentials: ['EC2_SSH_private_Key']) {
                    sh '''
                        ssh -o StrictHostKeyChecking=no ubuntu@$ec2_pub_key "cd / && ls -al"
                    '''
                }
            }
        }
    }
}
