pipeline {
    agent any 
    stages {
        stage('Build') {
            steps {
                sh 'ls'
                withCredentials([usernamePassword(credentialsId: "scribblesID", usernameVariable: "DockerHubUser", passwordVariable: "DockerHubPass")]) {
                    sh "docker login -u ${env.DockerHubUser} -p ${env.DockerHubPass}"
                }
            }
            steps {
                sh "docker-compose build"
                sh "docker images"
            } 
        }

        stage('Test') {
            steps {
                echo 'Testing'
            } 
        }

        stage('Deployment') {
            steps {
                dir ('build') {
                    sh 'ls'
                }
            } 
        }
    }
}