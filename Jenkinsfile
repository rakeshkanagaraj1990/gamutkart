pipeline {
    agent none
    stages {
        stage ('pre-build') {
            agent {
                docker { image 'maven:3-alpine' }
            }
            steps {
                sh 'mvn --version'
            }
        }
    }
}
