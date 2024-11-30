// pipeline {
//     agent any
//     stages {
//         stage('Checkout') {
//             steps {
//                 echo 'Checking out code from GitHub...'
//                 git branch: 'main', url: 'https://github.com/SidraSaleem296/jenkins-webapp.git'
//             }
//         }
//         stage('Build Docker Image') {
//             steps {
//                 echo 'Building Docker image...'
//                 script {
//                     // Try building without sudo first
//                     def buildCommand = 'docker build -t sample-web-app .'
//                     try {
//                         sh buildCommand
//                     } catch (Exception e) {
//                         echo 'Docker build failed without sudo, retrying with sudo...'
//                         sh "sudo ${buildCommand}"
//                     }
//                 }
//             }
//         }
//         stage('Run Docker Container') {
//             steps {
//                 echo 'Running Docker container...'
//                 script {
//                     // Try running without sudo first
//                     def runCommand = 'docker run -d -p 5000:5000 sample-web-app'
//                     try {
//                         sh runCommand
//                     } catch (Exception e) {
//                         echo 'Docker run failed without sudo, retrying with sudo...'
//                         sh "sudo ${runCommand}"
//                     }
//                 }
//             }
//         }
//     }
//     post {
//         always {
//             echo 'Pipeline execution completed!'
//         }
//         failure {
//             echo 'Pipeline failed. Please check logs for details.'
//         }
//     }
// }

pipeline {
    agent any

    stages {
        stage('Checkout App Code') {
            steps {
                echo 'Checking out code from GitHub (jenkins-webapp)...'
                git url: 'https://github.com/SidraSaleem296/jenkins-webapp.git', branch: 'main'
            }
        }

        stage('Build Docker Image') {
            steps {
                echo 'Building Docker image...'
                script {
                    sh 'docker build -t sample-web-app .'
                }
            }
        }

        stage('Run Docker Container') {
            steps {
                echo 'Running Docker container...'
                script {
                    sh 'docker run -d -p 5000:5000 sample-web-app'
                }
            }
        }

        stage('Checkout Selenium Tests') {
            steps {
                echo 'Checking out code from GitHub (selenium-automate)...'
                git url: 'https://github.com/SidraSaleem296/selenium-automate.git', branch: 'main'
            }
        }

        stage('Run Selenium Tests') {
            steps {
                echo 'Running Selenium tests...'
                script {
                    docker.image('python:3.9-slim').inside {
                        sh '''
                            apt-get update && apt-get install -y wget curl unzip chromium-driver
                            pip install --upgrade pip
                            pip install -r selenium-automate/requirements.txt
                            pytest selenium-automate/test_app.py
                        '''
                    }
                }
            }
            post {
                success {
                    echo 'Selenium tests passed!'
                }
                failure {
                    echo 'Selenium tests failed!'
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
