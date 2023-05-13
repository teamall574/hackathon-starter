pipeline {
    agent any
    environment {
                registryCredential = "anjitest"
                dockerimagename = "anji1592/kubetest"
                dockerImage = " "
            }
    stages {
        stage('checkout source') {
            steps{
                git 'https://github.com/teamall574/hackathon-starter.git'
            }
        }
        stage('build image') {
            steps {
                script {
                    dockerImage = docker.build dockerimagename
                }
            }
        }
        stage('push image') {
            steps {
                script {
                    docker.withRegistry( 'https://registry.hub.docker.com', registryCredential) {
                        dockerImage.push("latest")
                    }
                }
            }
        }
            stage('checking trivy version') {
                steps {
                    sh 'trivy --version'
                }
          }
        stage{
            sh 'trivy_output=$(trivy --severity HIGH,CRITICAL <image_name>:<image_tag>)'

        if echo "$trivy_output" | grep -q "High" || echo "$trivy_output" | grep -q "Critical"; then
        echo "Aborting build due to High or Critical vulnerabilities"
        exit 1
        fi
        }
     }
  }
