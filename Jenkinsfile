pipeline {
  agent none
  stages {
    stage('AppBuild') {
      agent {
        docker {
          image 'maven:3-alpine'
          args '-v /root/.m2:/root/.m2'
        }

      }
      steps {
        sh 'mvn clean install'
      }
    }

    stage('ImageBuild') {
      agent any
      options {
        skipDefaultCheckout(true)
      }
      steps {
        sh 'docker build -t rkdockerking/gamutkart:${BUILD_NUMBER} .'
      }
    }

    stage('ImagePush') {
      agent any
      environment {
        DOCKERHUB_CREDS = credentials('dockerhub')
      }
      options {
        skipDefaultCheckout(true)
      }
      steps {
        sh 'docker login --username $DOCKERHUB_CREDS_USR --password $DOCKERHUB_CREDS_PSW'
        sh 'docker push rkdockerking/gamutkart:${BUILD_NUMBER}'
      }
    }
    stage('DeployApp') {
      agent any
      environment {
        DOCKERHUB_CREDS = credentials('dockerhub')
      }
      options {
        skipDefaultCheckout(true)
      }
      steps {
        sh 'docker login --username $DOCKERHUB_CREDS_USR --password $DOCKERHUB_CREDS_PSW'
        sh 'docker run -dit --rm --name gamutgurus -p 8081:8080 rkdockerking/gamutkart:${BUILD_NUMBER}'
      }
    }
  }
  triggers {
    pollSCM('H/1 * * * * ')
  }
}
