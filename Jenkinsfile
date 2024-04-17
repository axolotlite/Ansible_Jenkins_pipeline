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
}
