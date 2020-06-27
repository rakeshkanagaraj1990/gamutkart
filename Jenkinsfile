pipeline {
    agent none
    stages {
        stage('AppBuild') {
            agent {
                docker {
                    image 'maven:3-alpine'
                    args '-v $WORKSPACE/.m2:/root/.m2'
                }
            }
            steps {
                sh 'mvn install'
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
            options {
                skipDefaultCheckout(true)
            }
            steps {
                script {
                    sshPublisher(
                            publishers:
                                    [
                                            sshPublisherDesc(
                                                    configName: 'RemoteHost1',
                                                    transfers: [
                                                            sshTransfer
                                                                    (
                                                                            sourceFiles: 'deploy.sh',
                                                                            patternSeparator: '[, ]+', 
                                                                            execCommand: 'chmod +x deploy.sh && sudo ./deploy.sh ${BUILD_NUMBER}',
                                                                            execTimeout: 120000

                                                                    )
                                                    ]
                                            )
                                    ]
                    )
                }
            }
        }
        stage('LocalCleanUp') {
            agent any
            options {
                skipDefaultCheckout(true)
            }
            steps {
                sh 'docker rmi rkdockerking/gamutkart:${BUILD_NUMBER}'
            }
        }
    }
    triggers {
        pollSCM('H/1 * * * * ')
    }
}
