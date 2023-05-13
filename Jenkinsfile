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
                    //sh 'bash anji.sh'
                           
                }
          }
        stage('code-analysis'){
        steps{
            sh 'npm install'
            withSonarQubeEnv('sonarqube-test') {
                sh 'npm install sonar-scanner'
                sh 'npm run sonar-test'
                }
            }   
       }
       stage('quality gate staus') {
            steps {
                script{
                waitForQualityGate abortPipeline: true, credentialsId: 'sonar-token'
                }
            }
        }
     }
  }
