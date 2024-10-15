pipeline {
    agent any
    triggers {
        // 当通过Gerrit代码审查并合并到分支时触发
        gerritTrigger {
            events {
                changed()
                submitted()
            }
        }
        // 或者使用GitHub的Webhook触发
        github {
        }
        pollSCM('H/5 * * * *') // 每5分钟检查一次更改
    }
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
