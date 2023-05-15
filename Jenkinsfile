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
        stage("sonarqube analysis"){
          steps{
          nodejs(nodeJSInstallationName: 'nodejs'){
            sh 'npm install'
             withSonarQubeEnv('sonar') {
                sh 'npm install sonar-scanner'
                sh 'npm run sonar'
             }  
           }
         }
       }
        stage('k8s deploy') {
        steps{
            withKubeConfig(caCertificate: '', clusterName: '', contextName: '', credentialsId: 'k8s', namespace: '', restrictKubeConfigAccess: false, serverUrl: '') {
                sh 'kubectl get pods'
            }
          }
       }
    }
}
