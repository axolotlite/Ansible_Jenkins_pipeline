pipeline {
	agent any
	environment{
		SMTP_PASSWORD=credentials("SMTP_PASSWORD")
	}
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
			send_mail("bash")
			send_mail("jenkins")
			send_mail("ansible")
			cleanWs()
		}
	}
}
def send_mail(method) {
	def currentDate = sh(script:"date \"+%Y/%m/%d %T\"", returnStdout: true)
	def subject="Automated Pipeline email for ${JOB_NAME}: ${BUILD_NUMBER}(${currentBuild.currentResult})"
	def body="""
This is an automated mail sent to you through ${method}.
Pipeline execution status: ${currentBuild.currentResult}
nginxG group users: tbd
Pipeline Date: ${currentDate}
"""
        switch(method){
                case "bash":
                        sh "./scripts/mailto.sh \"${subject}\" \"${body}\""
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
