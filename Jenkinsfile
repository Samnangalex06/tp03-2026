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

                FOR /F "tokens=1" %%i IN ('docker ps -q --filter "publish=8000"') DO docker stop %%i

                docker run -d -p 8000:8000 --name tp03-container tp03-laravel
                '''
            }
        }
    }

    post {
        success {
            bat '''
            curl -X POST https://api.telegram.org/bot8710184853:AAG6IEWeNx3-l1Ryviq4-2_PHjrWjD8N5us/sendMessage ^
            -d chat_id=1243164004 ^
            -d text="Jenkins Build Success"
            '''
        }

        failure {
            bat '''
            curl -X POST https://api.telegram.org/bot8710184853:AAG6IEWeNx3-l1Ryviq4-2_PHjrWjD8N5us/sendMessage ^
            -d chat_id=1243164004 ^
            -d text="Jenkins Build Failed"
            '''
        }
    }
}
