pipeline {
    parameters {
        booleanParam(name: 'autoApprove', defaultValue: false, description: 'Automatically apply Terraform changes?')
        booleanParam(name: 'destroyInfra', defaultValue: false, description: 'Destroy AWS infrastructure?')
    }

    agent any

    stages {
        stage('Checkout') {
            steps {
                script {
                    dir("ci-cd-terraform-jenkins-aws") {
                        git branch: 'main', credentialsId: 'Github-PAT', url: 'https://github.com/AkhileshGurmit/Terraform_EC2_s3.git'
                    }
                }
            }
        }

        stage('Plan') {
            steps {
                withCredentials([
                    string(credentialsId: 'AWS_ACCESS_KEY_ID', variable: 'AWS_ACCESS_KEY_ID'),
                    string(credentialsId: 'AWS_SECRET_ACCESS_KEY', variable: 'AWS_SECRET_ACCESS_KEY')
                ]) {
                    sh '''
                        cd ci-cd-terraform-jenkins-aws

                        terraform init
                        terraform plan -out=tfplan
                        terraform show -no-color tfplan > tfplan.txt
                    '''
                }
            }
        }

        stage('Approval') {
            when {
                not { equals expected: true, actual: params.autoApprove }
            }
            steps {
                script {
                    def plan = readFile 'ci-cd-terraform-jenkins-aws/tfplan.txt'
                    input message: "Do you want to apply the plan?",
                          parameters: [text(name: 'Plan', description: 'Please review the Terraform plan', defaultValue: plan)]
                }
            }
        }

        stage('Apply') {
            steps {
                withCredentials([
                    string(credentialsId: 'AWS_ACCESS_KEY_ID', variable: 'AWS_ACCESS_KEY_ID'),
                    string(credentialsId: 'AWS_SECRET_ACCESS_KEY', variable: 'AWS_SECRET_ACCESS_KEY')
                ]) {
                    sh '''
                        cd ci-cd-terraform-jenkins-aws
                        terraform apply -auto-approve
                    '''
                }
            }
        }

        stage('Destroy') {
            when {
                equals expected: true, actual: params.destroyInfra
            }
            steps {
                input message: "Are you sure you want to destroy the infrastructure?", ok: "Yes, Destroy"
                withCredentials([
                    string(credentialsId: 'AWS_ACCESS_KEY_ID', variable: 'AWS_ACCESS_KEY_ID'),
                    string(credentialsId: 'AWS_SECRET_ACCESS_KEY', variable: 'AWS_SECRET_ACCESS_KEY')
                ]) {
                    sh '''
                        cd ci-cd-terraform-jenkins-aws
                        terraform destroy -auto-approve
                    '''
                }
            }
        }
    }
}
