pipeline {
    agent any
    stages {
        stage('checkout source') {
            steps{
                git 'https://github.com/teamall574/hackathon-starter.git'
            }
        }
        stage('docker build'){
            steps{
                sh 'docker build -t anjitest .'
                sh 'docker run -dit --name simple-project -p 8080:80 anjitestt'
                sh 'docker tag anjitest anji1592/anjitest'
            }
        }
      }
   }
