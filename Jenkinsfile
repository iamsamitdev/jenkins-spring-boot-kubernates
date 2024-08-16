pipeline {
    agent any

    environment {
        MAVEN_ARGS = "-e clean install"
        DOCKER_IMAGE = "iamsamitdev/springboot-app-jenkins:latest"
    }

    stages {

        stage('Build Maven Project') {
            steps {
                withMaven(maven: 'MAVEN_HOME') {
                    sh "mvn ${MAVEN_ARGS}"
                }
            }
        }
        // stage('Run Spring Application') {
        //     steps {
        //         withEnv(["PATH=/usr/local/bin:/usr/bin:/bin:/usr/sbin:/sbin:/usr/local/sbin"]) {
        //             sh "java -jar target/demo-0.0.1-SNAPSHOT.jar"
        //         }
        //     }
        // }
        stage('Build Docker Image') {
            steps {
                withEnv(["PATH=/usr/local/bin:/usr/bin:/bin:/usr/sbin:/sbin:/usr/local/sbin"]) {
                    // สร้าง Docker image จาก Dockerfile ที่อยู่ใน project
                    sh "docker build -t ${DOCKER_IMAGE} ."

                    // ลบ dangling images (images ที่ไม่มี tag)
                    sh "docker image prune -f"

                    // แสดงรายชื่อ Docker images ทั้งหมดที่มีอยู่หลังจาก build เสร็จ
                    sh "docker images"
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