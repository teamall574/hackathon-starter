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
                    sh 'trivy image anji1592/kubetest:latest'
                    //sh 'trivy --no--progress --exit-code 1 --severity HIGH,CRITICAL anji1592/kubetest:latest'
                }
          }
     }
  }
