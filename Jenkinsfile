pipeline {
    agent any
    GenericTrigger(
    	genericVariables: [
     		[key: 'service', value: '$.service'],
     		[key: 'image', value: '$.image']
     	],
     	token: env.JENKINS_TOKEN,
     	causeString: 'Triggered by $image',
     	printContributedVariables: true,
     	printPostContent: true
    )

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
     				-X PUT \
     				--data-binary "@config/logstash-cm.yml" \
				https://${KUBERNETES_SERVICE_HOST}:443/api/v1/namespaces/elk/configmaps/logstash-config
	        '''
            }
        }
    }
}
