#!/usr/bin/env groovy

node {
    stage('checkout') {
        steps {
            checkout scm
        }
    }

    //stage('OWASP Dependency-Check Vulnerabilities') {
    //    steps {
    //        dependencyCheck additionalArguments: ''' 
    //            -o './'
    //            -s './'
    //            -f 'ALL' 
    //            --prettyPrint''', odcInstallation: 'OWASPDepCheck'
    //        
    //        dependencyCheckPublisher pattern: 'dependency-check-report.xml'
    //    }
    //}


	  post {
      	success {
              bat 'echo Success'
              emailext (
	  			subject: "SUCCESS: Job '${env.JOB_NAME} [${env.BUILD_NUMBER}]'",
	  			body: """<p>SUCCESS: Job '${env.JOB_NAME} [${env.BUILD_NUMBER}]':</p>
	  				<p>Check console output at &QUOT;<a href='${env.BUILD_URL}'>${env.JOB_NAME} [${env.BUILD_NUMBER}]</a>&QUOT; for more information.
            The OWASP Deo</p>""",
	  			to: "f.walliser@quality-miners.de, t.trebes@quality-miners.de",
	  			attachLog: true
	  		  )
      	}

      	failure {
              bat 'echo Failed'
              emailext (
	  			subject: "FAILED: Job '${env.JOB_NAME} [${env.BUILD_NUMBER}]'",
	  			body: """<p>FAILED: Job '${env.JOB_NAME} [${env.BUILD_NUMBER}]':</p>
	  				<p>Check console output at &QUOT;<a href='${env.BUILD_URL}'>${env.JOB_NAME} [${env.BUILD_NUMBER}]</a>&QUOT; for more information</p>""",
	  			to: "f.walliser@quality-miners.de, t.trebes@quality-miners.de",
	  			attachLog: true
	  		  )
      	}

      	always {
              bat 'echo Done'
              emailext (
	  			subject: "DONE: Job '${env.JOB_NAME} [${env.BUILD_NUMBER}]'",
	  			body: """<p>DONE: Job '${env.JOB_NAME} [${env.BUILD_NUMBER}]':</p>
	  				<p>Check console output at &QUOT;<a href='${env.BUILD_URL}'>${env.JOB_NAME} [${env.BUILD_NUMBER}]</a>&QUOT; for more information""",
	  			to: "f.walliser@quality-miners.de, t.trebes@quality-miners.de",
	  			attachLog: false
	  		  )
      	}
      }
}

