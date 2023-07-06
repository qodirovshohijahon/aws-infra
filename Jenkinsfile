pipeline {

  agent any
    parameters {
        string(
            name: 'accessKey', 
            defaultValue: '', 
            description: 'AWS Access Key'
        )
        string(
            name: 'secretKey', 
            defaultValue: '', 
            description: 'AWS Secret Key'
        )
        string(
            name: 'defaultRegion', 
            defaultValue: 'us-east-1', 
            description: 'AWS Default Region'
        )
        string(
            name: 'ecrName', 
            defaultValue: 'edp-dev-registry', 
            description: 'AWS ECR Name'
        )        
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

    stage("terraform Action") {
        steps {
            script {
                sh """
                    terraform -chdir=./ecr plan \
                        -var="access_key=${params.accessKey}" \
                        -var="secret_key=${params.secretKey}" \
                        -var="region=${params.defaultRegion}"
                """
            }
        }
    }
    stage("Terraform Apply") {
        steps {
            script {
                sh """
                    terraform -chdir=./ecr apply --auto-approve=true \
                        -var="access_key=${params.accessKey}" \
                        -var="secret_key=${params.secretKey}" \
                        -var="region=${params.defaultRegion}"
                """
            }
        }
    }
    stage("Terraform Destroy") {
        steps {
            script {
                sh """
                    terraform -chdir=./ecr destroy --auto-approve=true \
                        -var="access_key=${params.accessKey}" \
                        -var="secret_key=${params.secretKey}" \
                        -var="region=${params.defaultRegion}" \
                        -var="ecr_name=${params.ecrName}"
                """
            }
        }
    }
  }
}