pipeline {

    agent any

    stages {
        stage('Build') {
            steps {
                sh 'echo Building... '
            }
        }
        stage('Test') {
            steps {
                sh 'echo Testing... '
            }
        }
        stage('Deploy') {
            steps {

                sh '''
			ls -la
			a=`git rev-parse HEAD`;
			b=`git log -1 --format="%H" -- config/logstash-cm.yml`;
			if [ x"$a" != x"$b" ]; then
				echo "The config/logstash-cm.yml file isn't changed in this commit, skip apply!";
				exit(0);
			fi

			token=$(cat /var/run/secrets/kubernetes.io/serviceaccount/token)
			curl  --cacert  /var/run/secrets/kubernetes.io/serviceaccount/ca.crt \
				-H "Authorization: Bearer $token" \
     				-H "Content-Type: application/yaml; charset=utf-8" \
     				-X PUT \
     				--data-binary "@config/logstash-cm.yml" \
				https://${KUBERNETES_SERVICE_HOST}:443/api/v1/namespaces/elk/configmaps/logstash-config && \
			curl  --cacert  /var/run/secrets/kubernetes.io/serviceaccount/ca.crt \
				-H "Authorization: Bearer $token" \
     				-H "Content-Type: application/merge-patch+json; charset=utf-8" \
     				-X PATCH \
     				-d '{"spec":{"replicas":0}}' \
				https://${KUBERNETES_SERVICE_HOST}:443/apis/apps/v1/namespaces/elk/deployments/logstash && \
				sleep 1 && \
			curl  --cacert  /var/run/secrets/kubernetes.io/serviceaccount/ca.crt \
				-H "Authorization: Bearer $token" \
     				-H "Content-Type: application/merge-patch+json; charset=utf-8" \
     				-X PATCH \
     				-d '{"spec":{"replicas":1}}' \
				https://${KUBERNETES_SERVICE_HOST}:443/apis/apps/v1/namespaces/elk/deployments/logstash

	        '''
            }
        }
    }
}
