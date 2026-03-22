pipeline {
    agent any
    
    // Injecting your secure AWS credentials into the Jenkins environment
    environment {
        AWS_ACCESS_KEY_ID     = credentials('AWS_ACCESS_KEY_ID')
        AWS_SECRET_ACCESS_KEY = credentials('AWS_SECRET_ACCESS_KEY')
        AWS_DEFAULT_REGION    = 'eu-central-1'
    }

    stages {
        stage('Checkout Code') {
            steps {
                // Jenkins automatically pulls the latest code from GitHub
                checkout scm
            }
        }

        stage('Terraform Init') {
            steps {
                // We ONLY want Jenkins to run the main folder, not the bootstrap!
                dir('main') {
                    sh 'terraform init'
                }
            }
        }

        stage('Terraform Plan') {
            steps {
                dir('main') {
                    // Saves the plan to a file so we know exactly what will be built
                    sh 'terraform plan -out=tfplan'
                }
            }
        }

        stage('Terraform Apply') {
            steps {
                dir('main') {
                    // -auto-approve tells Terraform not to wait for you to type "yes"
                    sh 'terraform apply -auto-approve tfplan'
                }
            }
        }
    }
    
    post {
        success {
            echo '✅ Infrastructure deployed successfully! The Phoenix is live.'
        }
        failure {
            echo '❌ Pipeline failed. Check the Terraform syntax.'
        }
    }
}
