pipeline {
    agent any

    stages {
        stage('Copy index.html to Apache server') {
            steps {
                echo 'Copying...'
                scp /var/lib/jenkins/workspace/acad-dreygos-pipeline/index.html ec2-user@54.244.169.245:/home/ec2-user
            }
        }
        stage('SSH into Apache instance') {
            steps {
                echo 'SSH-ing...'
                ssh ec2-user@54.244.169.245
            }
        }
        stage('Copy index.html file into Apache folder') {
            steps {
                echo 'Copying...'
                sudo mv index.html /var/www/html/index.html
                exit
            }
        }
    }
}
