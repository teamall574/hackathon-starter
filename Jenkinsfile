pipeline {
    agent any
    environment {
                registryCredential = "anjitest"
            }
    stages {
        stage('checkout source') {
            steps{
                git 'https://github.com/teamall574/hackathon-starter.git'
            }
        }
        stage('build image ') {
            steps {
                sh 'docker build -t anjiii .'
                sh 'docker tag anjiii anji1592/anjitest'
            }
        }
        stage('push image ') {
            steps {
                script {
                    docker.withRegistry( 'https://registry.hub.docker.com', registryCredential) {
                        sh 'docker push anji1592/anjitest:latest'
                    }
                }
            }
        }
     }
  }
