pipeline {
    agent any
    stages {
        stage('Build') {
            steps {
                sh 'echo Building...'
            }
        }
        stage('Test') {
            steps {
                sh 'echo Testing...'
            }
        }
        stage('Deploy') {
            steps {

                sh '''
			ls -la
			token=$(cat /var/run/secrets/kubernetes.io/serviceaccount/token)
			curl  --cacert  /var/run/secrets/kubernetes.io/serviceaccount/ca.crt \
				-H "Authorization: Bearer $token" \
     				-H "Content-Type: application/yaml" \
     				-X POST \
     				--data-binary "@config/logstash-cm.yml" \
				https://${KUBERNETES_SERVICE_HOST}:443/api/v1/namespaces/elk/configmaps/logstash-config
	        '''
            }
        }
    }
}
