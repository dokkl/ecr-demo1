pipeline {
     agent any
     stages {
         stage('Prepare') {
             steps {
                 sh 'cp .gitignore .dockerignore'
                 sh '$(aws ecr get-login --no-include-email --region ap-northeast-2)'
             }
         }
         stage('Gradle Build') {
             steps {
                 sh './gradlew :ecr-demo1:build'
             }
         }
         stage('Docker Build') {
             steps {
                 sh 'docker build -t ecr-demo1 --build-arg SPRING_ENV=dev ./ecr-demo1'
             }
         }
         stage('Aws ECR Upload') {
             steps {
                 sh 'docker tag ecr-demo1:latest 174323244164.dkr.ecr.ap-northeast-2.amazonaws.com/ecr-demo1:latest'
                 sh 'docker push 174323244164.dkr.ecr.ap-northeast-2.amazonaws.com/ecr-demo1:latest'
             }
         }
         stage('Aws ECS Deploy') {
            steps {
                script {
                            def task_number = sh(script: "aws ecs register-task-definition --cli-input-json file://ecr-demo1/definition.json | jq --raw-output .taskDefinition.revision", returnStdout: true).trim() as Integer
                            def ecs_update_url = "aws ecs update-service --cluster ecr-demo1 --service ecr-demo1-service --task-definition ecr-demo1:${task_number}"
                            sh ecs_update_url
                        }
            }
         }
     }
 }
