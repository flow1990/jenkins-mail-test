#!/usr/bin/env groovy

pipeline {
    agent any

    stages {
      stage('checkout') {
        steps {
          checkout scm
        }
      }

      stage('create compodoc') {
        steps {
          sh 'sudo npm install -g @compodoc/compodoc'
          sh 'touch tsconfig.doc.json'
          //sh 'compodoc -p tsconfig.doc.json -s -r 8888'
          sh 'sudo nohup compodoc -p tsconfig.doc.json &'
          script {
            compodocProcess = sh(script: 'sudo nohup compodoc -p tsconfig.doc.json -s -r 8888 &', returnStdout: true).trim()
          }
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
    	always {
        emailext (
		      subject: "Dependency Check: Job '${env.JOB_NAME} [${env.BUILD_NUMBER}]'",
		      body: """Dependency Check: Job '${env.JOB_NAME} [${env.BUILD_NUMBER}]': Check console output at ${env.BUILD_URL} for more information.
          Compodoc-PID: ${compodocProcess}
          Directory: ${PWD}/workspace/${env.JOB_NAME}/""",
		      to: "f.walliser@quality-miners.de",
		      attachLog: true,
          attachmentsPattern: 'dependency-check-report.xml, dependency-check-report.xml, dependency-check-report.html, dependency-check-report.json, dependency-check-report.csv, dependency-check-report.sarif, dependency-check-jenkins.html, dependency-check-junit.xml'
			  )
    	}
    }
}