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
            echo "Terraform action is...}"
            script {
                sh''' 
                    terraform -chdir=./ecr plan \
                    -var="access_key=${params.accessKey}" \
                    -var="secret_key=${params.secretKey}"
                '''
        }
        }
    }
  }
}