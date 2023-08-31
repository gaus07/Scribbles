pipeline {
    agent any 
    stages {
        stage('Build') {
            steps {
                sh 'ls'
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