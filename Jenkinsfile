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
        // Ensure that python3 and pip are in the PATH for the Jenkins build
        PATH = "/usr/bin:$PATH"
    }

    stages {
        stage('Declarative: Checkout SCM') {
            steps {
                checkout scm
            }
        }

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

        stage('Debug Environment') {
            steps {
                echo 'Debugging Python and pip environment...'
                script {
                    sh 'which python3'  // Show where python3 is installed
                    sh 'which pip'      // Show where pip is installed
                    sh 'python3 --version'  // Check python version
                    sh 'python3 -m pip --version'  // Check pip version
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
                    // Explicitly use python3 to ensure the correct pip version is used
                    sh 'python3 -m pip install -r selenium-automate/requirements.txt'
                    sh 'python3 selenium-automate/run_tests.py'  // Replace with actual test script if different
                }
            }
        }

        stage('Declarative: Post Actions') {
            steps {
                echo 'Pipeline execution completed!'
                echo 'Pipeline failed. Please check logs for details.' 
            }
        }
    }

    post {
        always {
            // Clean up Docker container if necessary
            sh 'docker ps -q --filter "ancestor=sample-web-app" | xargs -r docker stop | xargs -r docker rm'
        }
    }
}
