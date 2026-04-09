pipeline {
    agent any

    stages {
        stage('Build Docker') {
            steps {
                sh 'docker build -t tp03-laravel .'
            }
        }

        stage('Run Container') {
            steps {
                sh '''
                docker stop tp03-container || true
                docker rm tp03-container || true
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
