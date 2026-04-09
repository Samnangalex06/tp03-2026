pipeline {
    agent any

    stages {
        stage('Build Docker') {
            steps {
                bat 'docker build -t tp03-laravel .'
            }
        }

        stage('Run Container') {
            steps {
                bat '''
                docker stop tp03-container || echo no container
                docker rm tp03-container || echo no container
                docker run -d -p 8000:8000 --name tp03-container tp03-laravel
                '''
            }
        }
    }

    post {
        failure {
            echo 'Build Failed!'
        }
    }
}
