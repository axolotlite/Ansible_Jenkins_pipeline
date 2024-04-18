## Ansible Playbook Info
This playbook was mainly made to install nginx on the 3rd VM, but I kept some of the roles I used for testing
### Structure
```
.
├── ansible.cfg
├── files
│   └── gogs.service
├── InstallNginx.yml
├── inventory.txt
├── main.yml
└── roles
    ├── mailto
    │   ├── defaults
    │   │   └── main.yml
    │   └── tasks
    │       └── main.yml
    ├── nginx
    │   └── tasks
    │       └── main.yml
    └── ssh_setup
        └── tasks
            └── main.yml
```
- `ansible.cfg`: prevents known hosts key checking
- `files/`: contains the gogs service in case I automate the setup of gogs on vm2
- `InstallNginx.yml`: calls the `nginx` role
- `main.yml`: contains several tagged roles, used to call `mailto` through the `mail` tag
- `roles/mailto/defaults`: acquires the necessary environment variables to use ansible built-in mail module
- `roles/mailto/tasks`: calls the mail module
- `roles/ssh_setup`: used to transfer ssh key, not used in the jenkinsfile
