pipeline {
    agent any

    stages {
        stage('Deploying Terraform resources') {
            steps {
                echo 'Deploying...'
                sh 'cd /var/lib/jenkins/workspace/acad-dreygos-pipeline'
                sh "sudo terraform init"
                sh "sudo terraform plan"
                sh "sudo terraform apply -auto-approve"
            }
        }
    }
}
