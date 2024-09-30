pipeline{
    agent any
    environment {
        AWS_ACCESS_KEY_ID     = credentials('aws-cred')
        AWS_SECRET_ACCESS_KEY = credentials('aws-cred')
    }
    stages {
        stage('aws'){
            steps  {

       withCredentials([aws(accessKeyVariable: 'AWS_ACCESS_KEY_ID', credentialsId: 'aws-cred', secretKeyVariable: 'AWS_SECRET_ACCESS_KEY')]) {
    // some block
    }
  }
} 
         stages {
        stage('Build') {
            steps {
                sh 'mvn clean package'
            }
        }

        stage('Check JAR') {
            steps {
                sh 'ls -l target/'
            }
        }

        stage('Run JAR') {
            steps {
                sh "java -jar /var/lib/workspace/target/MyMart-0.0.1-SNAPSHOT.jar"
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
