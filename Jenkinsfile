pipeline {

  agent any

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
            sh('terraform -chdir=./ecr plan')
        }
    }
}
}