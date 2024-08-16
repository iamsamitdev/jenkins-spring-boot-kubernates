pipeline {
    agent any

    environment {
        MAVEN_ARGS = "-e clean install"
    }

    stages {

        // Test Clone Repository
        stage('Clone Repository') {
            steps {
                sh 'git clone https://github.com/iamsamitdev/jenkins-spring-boot-kubernates.git'
            }
        }

        stage('Build Maven Project') {
            steps {
                withMaven(maven: 'MAVEN_HOME') {
                    sh "mvn ${MAVEN_ARGS}"
                }
            }
        }
        stage('Run Spring Application') {
            steps {
                withEnv(["PATH=/usr/local/bin:/usr/bin:/bin:/usr/sbin:/sbin:/usr/local/sbin"]) {
                    sh "java -jar target/demo-0.0.1-SNAPSHOT.jar"
                }
            }
        }
    }

    post {
        always {
            // ทำความสะอาด workspace หลังการรัน pipeline เสร็จ
            cleanWs()
        }
        success {
            echo 'Pipeline completed successfully'
        }
        failure {
            echo 'Pipeline failed'
        }
    }
}