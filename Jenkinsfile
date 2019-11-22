pipeline {
    agent any

    stages {
        stage('Copy index.html to Apache server') {
            steps {
                echo 'Copying...'
                sh 'scp /var/lib/jenkins/workspace/acad-dreygos-pipeline/index.html ec2-user@54.244.169.245:/home/ec2-user'
            }
        }
        stage('SSH into Apache instance and copy index.html into correct location') {
            steps {
                echo 'SSH-ing...'
                sh 'ssh ec2-user@54.244.169.245 "sudo mv index.html /var/www/html/index.html && exit"'
            }
        }
        stage('Deploying Terraform resources') {
            steps {
                echo 'Deploying...'
                sh 'cd /var/lib/jenkins/workspace/acad-dreygos-pipeline'
                //sh 'sudo su'
                sh 'echo '' | sudo terraform plan'
                //sh 'terraform apply'
            }
        }
    }
}
