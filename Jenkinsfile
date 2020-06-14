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
        REMOTEHOST_CREDS = credentials('remotehost')
      }
      options {
        skipDefaultCheckout(true)
      }
      steps {
          withCredentials([sshUserPrivateKey(credentialsId: 'remotehost', keyFileVariable: 'REMOTEHOST_KEY', passphraseVariable: '', usernameVariable: 'vagrant')])
          script {
          def remote = [:]
          remote.name = "RemoteHost"
          remote.host = "192.168.0.104"
          remote.allowAnyHosts = true
          remote.user = vagrant
          remote.identityFile = "$REMOTEHOST_KEY"
          sshCommand remote: remote, command: "sudo docker ps -a" 
          }
      }
    }
  }
  triggers {
    pollSCM('H/1 * * * * ')
  }
}
