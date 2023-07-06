pipeline {

  agent any
    parameters {
        string(
            name: 'DEFAULT_REGION', 
            defaultValue: 'us-east-1', 
            description: 'AWS Default Region'
        )
        string(
            name: 'ECR_NAME', 
            defaultValue: 'edp-dev-registry', 
            description: 'AWS ECR Name'
        )        
    }

    environment {
        AWS_ACCESS_KEY_ID     = credentials('AWS_ACCESS_KEY_ID')
        AWS_SECRET_ACCESS_KEY = credentials('AWS_SECRET_ACCESS_KEY')
    }

  stages {

    stage('Checkout') {
        steps {
          checkout(
            [
                $class: 'GitSCM',
                branches: [[name: ' * /main']], 
                extensions: [], 
                userRemoteConfigs: [[url: 'https://github.com/qodirovshohijahon/aws-infra.git']]
            ]
        )
        }

    }
    stage("terraform init") {
        steps {
            sh('terraform -chdir=./ecr init')
        }
    }

    stage("Terraform Initialization") {
        steps {
            script {
                sh """
                    terraform -chdir=./ecr plan \
                        -var="access_key=${env.ACCESS_KEY_ID}" \
                        -var="secret_key=${env.AWS_SECRET_ACCESS_KEY}" \
                        -var="region=${params.DEFAULT_REGION}"
                """
            }
        }
    }
    stage("Terraform Apply") {
        steps {
            script {
                sh """
                    terraform -chdir=./ecr apply --auto-approve=true \
                        -var="access_key=${params.ACCESS_KEY_ID}" \
                        -var="secret_key=${env.AWS_SECRET_ACCESS_KEY}" \
                        -var="region=${params.DEFAULT_REGION}" \
                        -var="ecr_name=${params.ECR_NAME}"
                """
            }
        }
    }
    stage("Terraform Destroy") {
        steps {
            script {
                sh """
                    terraform -chdir=./ecr destroy --auto-approve=true \
                        -var="access_key=${params.ACCESS_KEY_ID}" \
                        -var="secret_key=${env.AWS_SECRET_ACCESS_KEY}" \
                        -var="region=${params.DEFAULT_REGION}" \
                        -var="ecr_name=${params.ECR_NAME}"
                """
            }
        }
    }
  }
}