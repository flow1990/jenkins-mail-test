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
          sh 'compodoc -p tsconfig.doc.json'
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

      stage('Deploy to Docker Container') {
          environment {
              DOCKER_IMAGE_NAME = "compodoc-webserver" // Name des Docker-Images
              CONTAINER_PORT = 8080 // Der Port, auf dem der Container laufen soll
              HOST_PORT = 8888 // Der Port, auf den der Host den Container zugreift
          }
          steps {
              script {
                  // Docker Container bauen
                  sh "docker build -t ${DOCKER_IMAGE_NAME} ."
                  
                  // Docker Container starten und Port weiterleiten
                  sh "docker run -d -p ${HOST_PORT}:${CONTAINER_PORT} ${DOCKER_IMAGE_NAME}"
              }
          }
      }
    }

	post {
    	always {
        emailext (
		      subject: "Dependency Check: Job '${env.JOB_NAME} [${env.BUILD_NUMBER}]'",
		      body: """Dependency Check: Job '${env.JOB_NAME} [${env.BUILD_NUMBER}]': Check console output at ${env.BUILD_URL} for more information.""",
		      to: "f.walliser@quality-miners.de",
		      attachLog: true,
          attachmentsPattern: 'dependency-check-report.xml, dependency-check-report.xml, dependency-check-report.html, dependency-check-report.json, dependency-check-report.csv, dependency-check-report.sarif, dependency-check-jenkins.html, dependency-check-junit.xml'
			  )
    	}
    }
}