#!/usr/bin/env groovy

pipeline {
    agent any

    stages {
      stage('checkout') {
        steps {
          checkout scm
        }
      }
  
      stage('OWASP Dependency-Check Vulnerabilities') {
        steps {
          dependencyCheck additionalArguments: ''' 
              -o './'
              -s './'
              -f 'ALL' 
              --prettyPrint''', odcInstallation: 'OWASPDepCheck'
          
          dependencyCheckPublisher pattern: 'dependency-check-report.xml'
        }
      }
    }

	post {
    	success {
        sh 'echo Success'
        emailext (
				  subject: "SUCCESS: Job '${env.JOB_NAME} [${env.BUILD_NUMBER}]'",
				  body: """SUCCESS: Job '${env.JOB_NAME} [${env.BUILD_NUMBER}]':</p>
			          <p>Check console output at &QUOT;<a href='${env.BUILD_URL}'>${env.JOB_NAME} [${env.BUILD_NUMBER}]</a>&QUOT; for more information.""",
				  to: "f.walliser@quality-miners.de",
				  attachLog: true,
          attachmentsPattern: 'dependency-check-report.xml, dependency-check-report.xml, dependency-check-report.html, dependency-check-report.json, dependency-check-report.csv, dependency-check-report.sarif, dependency-check-jenkins.html, dependency-check-junit.xml'
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
          attachmentsPattern: 'dependency-check-report.xml, dependency-check-report.xml, dependency-check-report.html, dependency-check-report.json, dependency-check-report.csv, dependency-check-report.sarif, dependency-check-jenkins.html, dependency-check-junit.xml'
			  )
    	}
    }
}