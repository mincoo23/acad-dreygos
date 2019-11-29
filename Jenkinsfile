pipeline {
    agent any

    stages {
        stage('Deploying Terraform resources') {
            steps {
                echo 'Deploying...'
                sh """cd /var/lib/jenkins/workspace/acad-dreygosi-pipeline/terraform/ && \
                      sudo terraform init && \
                      sudo terraform plan && \
                      sudo terraform apply -auto-approve"""
            }
        }
    }
}
