#!/usr/bin/env groovy

pipeline {
    agent any

    stages {
      stage('checkout') {
        steps {
          checkout scm
        }
      }
  
      //stage('OWASP Dependency-Check Vulnerabilities') {
      //  steps {
      //    dependencyCheck additionalArguments: ''' 
      //        -o './'
      //        -s './'
      //        -f 'ALL' 
      //        --prettyPrint''', odcInstallation: 'OWASPDepCheck'
      //    
      //    dependencyCheckPublisher pattern: 'qmcloud-dependency-check-report.xml'
      //  }
      //}
    }

	post {
    	success {
        sh 'echo Success'
        emailext (
				  subject: "SUCCESS: Job '${env.JOB_NAME} [${env.BUILD_NUMBER}]'",
				  body: """<p>SUCCESS: Job '${env.JOB_NAME} [${env.BUILD_NUMBER}]':</p>
			          <p>Check console output at &QUOT;<a href='${env.BUILD_URL}'>${env.JOB_NAME} [${env.BUILD_NUMBER}]</a>&QUOT; for more information.""",
				  to: "f.walliser@quality-miners.de",
				  attachLog: true,
          attachmentsPattern: 'qmcloud-dependency-check-report.xml'
			  )
    	}

    	failure {
        sh 'echo Failed'
        emailext (
				  subject: "FAILED: Job '${env.JOB_NAME} [${env.BUILD_NUMBER}]'",
				  body: """<p>FAILED: Job '${env.JOB_NAME} [${env.BUILD_NUMBER}]':</p>
				  	    <p>Check console output at &QUOT;<a href='${env.BUILD_URL}'>${env.JOB_NAME} [${env.BUILD_NUMBER}]</a>&QUOT; for more information</p>""",
				  to: "f.walliser@quality-miners.de",
				  attachLog: true,
          attachmentsPattern: 'qmcloud-dependency-check-report.xml'
			  )
    	}
    }
}