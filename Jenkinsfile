pipeline {
    agent any
    stages {
        stage('Checkout') {
            steps {
                echo 'Checking out code from GitHub...'
                git branch: 'main', url: 'https://github.com/SidraSaleem296/jenkins-webapp.git'
            }
        }
        stage('Build Docker Image') {
            steps {
                echo 'Building Docker image...'
                script {
                    // Try building without sudo first
                    def buildCommand = 'docker build -t sample-web-app .'
                    try {
                        sh buildCommand
                    } catch (Exception e) {
                        echo 'Docker build failed without sudo, retrying with sudo...'
                        sh "sudo ${buildCommand}"
                    }
                }
            }
        }
        stage('Run Docker Container') {
            steps {
                echo 'Running Docker container...'
                script {
                    // Try running without sudo first
                    def runCommand = 'docker run -d -p 5000:5000 sample-web-app'
                    try {
                        sh runCommand
                    } catch (Exception e) {
                        echo 'Docker run failed without sudo, retrying with sudo...'
                        sh "sudo ${runCommand}"
                    }
                }
            }
        }
    }
    post {
        always {
            echo 'Pipeline execution completed!'
        }
        failure {
            echo 'Pipeline failed. Please check logs for details.'
        }
    }
}
