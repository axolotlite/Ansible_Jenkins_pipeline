pipeline {
	agent any
	stages{
		stage('Execute Ansible playbook'){
			steps{
				dir('ansible'){
					ansiblePlaybook(
						playbook: 'InstallNginx.yml',
						inventory: 'inventory.txt',
						credentialsId: 'ansible_creds'
					)
				}
			}
		}
	}
	post{
		always{
			environment{
				SMTP_PASSWORD=credentials("SMTP_PASSWORD")
			}
			send_mail("bash")
			send_mail("jenkins")
			send_mail("ansible")
			cleanWs()
		}
	}
}
def send_mail(method) {
	def subject="Automated Pipeline email for ${JOB_NAME}: ${BUILD_NUMBER}(${currentBuild.currentResult})"
	def body="""
This is an automated mail sent to you through ${method}.
Pipeline execution status: ${currentBuild.currentResult}
nginxG group users: tbd
Pipeline Date: ${TAG_DATE}
"""
        switch(method){
                case "bash":
                        sh "./mailto.sh \"${subject}\" \"${body}\""
                        break
                case "jenkins":
                        mail to: "${SMTP_USERNAME}",
                             subject: "${subject}"
                             body: "${body}"
                        break
                case "ansible":
                        dir('ansible'){
                            ansiblePlaybook(
                              playbook: 'main.yml',
                              inventory: 'inventory.txt',
                              credentialsId: 'ansible_creds',
                              extras: "--tags mail,finalize --extra-vars \"mail_subject=\"${subject}\" mail_body=\"${body}\"\""
                              )
                        }
                        break
        }
}
