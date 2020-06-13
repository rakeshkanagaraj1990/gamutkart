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
            agent {
                // Equivalent to "docker build -f Dockerfile.build --build-arg version=1.0.2 ./build/
                dockerfile { }
            }
        }
    }
}
