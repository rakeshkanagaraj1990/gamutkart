pipeline {
    agent none
    stages {
        stage ('build') {
            agent {
                docker { image 'maven:3-alpine' }
            }
            steps {
                sh 'mvn clean install'
            }
        }
        stage ('dockerbuild') {
            agent any
            steps {
                sh 'docker build -t rkdockerking/gamutkart:${BUILD_NUMBER} .'
            }
        }
    }
}
