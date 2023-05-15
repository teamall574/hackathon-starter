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
            stage('checking  docker security') {
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
       stage('Integrating with eks cluster and deploy'){
         steps {
            withAWS(credentials: 'credentialsss', region: 'ap-south-1'){
	            script {
	                sh ('aws eks update-kubeconfig--name anji --region ap-south-1')
	                sh "kubectl apply -f deployment.yml"
                 }
            }
         }
      }
   }
}
