pipeline{
    agent any
    environment {
        AWS_ACCESS_KEY_ID     = credentialsId('aws-cred')
        AWS_SECRET_ACCESS_KEY = credentialsId('aws-cred')
    }
    stages {
        stage('aws'){
            steps  {

       withCredentials([aws(accessKeyVariable: 'AWS_ACCESS_KEY_ID', credentialsId: 'aws-cred', secretKeyVariable: 'AWS_SECRET_ACCESS_KEY')]) {
    // some block
}
  }
   }          
        stage('dev'){

      steps  {
            sh '''
            terraform init
            terraform plan -out=dev.tfplan
            terraform apply dev.tfplan
            '''
            }
        }
    }
}
