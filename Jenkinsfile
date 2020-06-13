pipeline {
    agent none
    options {
        skipDefaultCheckout true
    }
    stages {
        stage ('build') {
            agent {
                docker { image 'maven:3-alpine' 
                         args  '-v /root/.m2:/root/.m2'
                }
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
