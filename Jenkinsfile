pipeline {
  agent any

  environment {
        APP_NAME = "simple-nodejs-demo-app" // Name of the application
        CONTAINER_NAME = "${APP_NAME}_container" //
        APP_INT_PORT = "3000"   // Internal port for the application
        APP_EXT_PORT = "3000"   // Exposed port for the application
        // BUILD_NUMBER is a built-in Jenkins environment variable.
        IMAGE_TAG = "${env.BUILD_NUMBER}" // Tag for the Docker image, based on the build number
    }

    stages { // Each stage represents a step in the CI/CD process.
        stage('Clean Workspace') { // Stage to clean the workspace before starting
            steps { // Steps are the individual actions within a stage.
                echo 'Cleaning workspace...' // Log message for clarity
                cleanWs() // Built-in step for cleaning workspace 
            }
        }
        stage('Checkout Code') { // Stage to checkout the code from the repository
            steps {
                script {
                    // Checkout the code from the specified branch
                    checkout scm: [$class: 'GitSCM', branches: [[name: 'dev']],
                                   userRemoteConfigs: [[url: 'https://github.com/xopsguru/node-demo-app.git']]
                    ]
                }
            }
        }
        stage('Build') {
            steps {
        script {
          // Build your application
            sh 'sleep 5' // Simulate work with a sleep command
            echo 'Building the application...' // Log message for clarity
                }
            }
        }

        stage('Test') {
            steps {
        script {
          // Run your tests
            sh 'sleep 7' // Simulate work with a sleep command
            echo 'Running tests...' // Log message for clarity
                }
             }
        }

        stage('Build Docker Image') {   
            steps {
          // Build your Docker image
            sh "docker build --no-cache --pull -t ${env.APP_NAME}:${env.IMAGE_TAG} ." // Build the Docker image
            echo 'Building Docker image...' // Log message for clarity
                }
        }
        
        stage('Stop & Remove existing container') {
            steps {
          // Stop and remove the existing Docker container if it exists
          // '|| true' makes the command succeed even if container doesn't exist
            sh """
                docker stop ${env.CONTAINER_NAME} || true // Stop the container, ignore error if it doesn't exist
                docker rm ${env.CONTAINER_NAME} || true // Remove the container, ignore error if it doesn't exist
                echo 'Stopped and removed existing container...' // Log message for clarity
            """
            }
        }
        stage('Run Docker Container') {
            steps {
                    // Run the Docker container
                    sh 'docker run -d --name ${env.CONTAINER_NAME} -p ${env.APP_EXT_PORT}:${env.APP_INT_PORT} ${env.APP_NAME}:${env.IMAGE_TAG}' // Command to run the Docker container
                    echo 'Running Docker container...' // Log message for clarity
                }
        }
    }
        post {
          always {
            
              // This block runs regardless of the build result
            echo "Pipeline for ${env.APP_NAME} completed with status: ${currentBuild.result}" // Log the build result
            echo "Docker container ${env.CONTAINER_NAME} is running on port ${env.APP_EXT_PORT}, Image tag: ${env.IMAGE_TAG}" // Log the running status of the container
            }
            success {
              // This block runs only if the build is successful
              echo "Pipeline for ${env.APP_NAME} completed successfully!" // Log success message
            }
            failure {
              // This block runs only if the build fails
              echo "Pipeline for ${env.APP_NAME} failed!" // Log failure message
            }
    }
}
