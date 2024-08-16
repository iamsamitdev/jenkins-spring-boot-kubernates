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
        stage('Push Docker Image') {
            steps {
                // Login เข้า Docker Hub และ push Docker image ที่สร้างขึ้น
                // Windows
                // withCredentials([string(credentialsId: 'dockerhub-credentials', variable: 'DOCKERHUB_PASSWORD')]) {
                //     bat "docker login -u iamsamitdev -p %DOCKERHUB_PASSWORD%"
                //     bat "docker push ${DOCKER_IMAGE}"
                // }

                // Linux & MacOS
                withCredentials([string(credentialsId: 'dockerhub-credentials', variable: 'DOCKERHUB_PASSWORD')]) {
                    withEnv(["PATH=/usr/local/bin:/usr/bin:/bin:/usr/sbin:/sbin:/usr/local/sbin"]) {
                        sh "echo ${DOCKERHUB_PASSWORD} | docker login -u iamsamitdev --password-stdin"
                        sh "docker push ${DOCKER_IMAGE}"
                    }
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