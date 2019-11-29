pipeline {
    agent any

    stages {
        stage('Deploying Terraform resources') {
            steps {
                echo 'Deploying...'
                sh "cd /var/lib/jenkins/workspace/acad-dreygosi-pipeline/terraform/ && sudo terraform init"
                sh "sudo terraform plan"
                sh "sudo terraform apply -auto-approve"
            }
        }
    }
}
