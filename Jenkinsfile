pipeline {
    agent any
    stages {
        stage('checkout source') {
            steps{
                git 'https://github.com/teamall574/hackathon-starter.git'
            }
        }
        stage('build image ') {
            steps {
                sh 'docker build -t anjiii'
                sh 'dokcer tag anjiii anji1592/anjitest'
            }
        }
        stage('push image ') {
            environment {
                registryCredential = 'anjitest'
            }
            steps {
                script {
                    docker.withRegistry( 'https://registry.hub.docker.com', registryCredential) {
                        dockerImage.push("latest")
                    }
                }
            }
        }
    }
