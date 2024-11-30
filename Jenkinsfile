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
    environment {
        DOCKER_IMAGE = 'sample-web-app'
    }
    stages {
        stage('Checkout App Code') {
            steps {
                echo 'Checking out code from GitHub (jenkins-webapp)...'
                git branch: 'main', url: 'https://github.com/SidraSaleem296/jenkins-webapp.git'
            }
        }
        stage('Checkout Selenium Tests') {
            steps {
                echo 'Checking out code from GitHub (selenium-automate)...'
                git branch: 'main', url: 'https://github.com/SidraSaleem296/selenium-automate.git'
            }
        }
        stage('Build Docker Image') {
            steps {
                echo 'Building Docker image...'
                script {
                    def buildCommand = "docker build -t ${DOCKER_IMAGE} ."
                    try {
                        sh buildCommand
                    } catch (Exception e) {
                        echo 'Docker build failed without sudo, retrying with sudo...'
                        sh "sudo ${buildCommand}"
                    }
                }
            }
        }
        stage('Install Selenium and Other Dependencies') {
            steps {
                echo 'Installing Selenium and other dependencies...'
                script {
                    // Install dependencies in the Docker container
                    sh 'docker exec <container_name> pip install selenium flask'
                }
            }
        }
        stage('Run Docker Container') {
            steps {
                echo 'Running Docker container...'
                script {
                    def runCommand = "docker run -d -p 5000:5000 ${DOCKER_IMAGE}"
                    try {
                        sh runCommand
                    } catch (Exception e) {
                        echo 'Docker run failed without sudo, retrying with sudo...'
                        sh "sudo ${runCommand}"
                    }
                }
            }
        }
        stage('Run Selenium Tests') {
            steps {
                echo 'Running Selenium tests...'
                script {
                    try {
                        // Run the Selenium tests inside the Docker container
                        sh 'docker exec <container_name> python selenium-automate/selenium_tests.py'
                    } catch (Exception e) {
                        echo 'Selenium tests failed!'
                        throw e
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
