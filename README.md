# nandrey_infra
nandrey Infra repository
```
bastion_IP = 35.207.150.141
someinternalhost_IP = 10.156.0.3
```
-============================-
```
testapp_IP = 35.246.220.53
testapp_port = 9292
```
Created from CLI GCP VM - reddit-app

Added three scripts for manual installation and run Puma:
install_ruby.sh - update system and install Ruby
install_mongodb.sh - install MongoDB
deploy.sh - deploy and start Puma

Added script for automatinc deploy and start for Ruby, MongoDB and Puma:
startup-script.sh

We can add this script to CLI command to run VM:

gcloud compute instances create reddit-app10 --boot-disk-size=10GB   --image-family ubuntu-1604-lts   --image-project=ubuntu-os-cloud   --machine-type=g1-small   --tags puma-server   --restart-on-failure --metadata-from-file startup-script=/Users/geppetto/Documents/learning/otus/nandrey_infra/startup-script.sh

Created bucket nandrey-otus-lava. Script added to root.

We can use this script from bucket in our CLI command:

gcloud compute instances create reddit-app10 --boot-disk-size=10GB   --image-family ubuntu-1604-lts   --image-project=ubuntu-os-cloud   --machine-type=g1-small   --tags puma-server   --restart-on-failure --metadata startup-script-url=gs://nandrey-otus-lava/startup-script.sh

CLI script to add Firawall Rule "default-puma-server" TCP,9292:

gcloud compute --project=otus-nandrey-infra firewall-rules create default-puma-server --direction=INGRESS --priority=1000 --network=default --action=ALLOW --rules=tcp:9292 --source-ranges=0.0.0.0/0 --target-tags=puma-server

-============================-

HW#7

1. Added variable.json to .gitignore

2. In folder ./packer added .json configs: ubuntu16.json and immutable.json to create two different GCE images. Variables are in variables.json.example . Use with -var-file=<VAR FILE NAME>

3. In folder ./packer added two folders: scripts and files . There are support scripts to create images in those folders

4. All scripts from previous HW#6 are moved to ./config-scripts

5. In folder ./config-scripts added script: create-redditvm.sh to create VM in GCE with ready image. Image contains Ruby, MongoDB and Puma. Puma is enabled to start at boot.

-============================-

HW#8

1. Added terraform folders with content:

./terraform
|_./terraform/files/
|  |_deploy.sh
|  |_puma.service
|
|_./main.tf
|_./outputs.tf
|_./terraform.tfvars.example
|_./variables.tf

2. With terraform and provided main.tf it's possible to create in GCE from base packer made image VM with running Puma and firewall rules for Puma service.

3.* It's possible to add several SSH keys with current main.tf , but exiting keys not described in main.rf will be deleted.

-============================-

HW#9

1. TF configuration from HW#8 is now changed to use modules (./modules folder)
2. TF configuration now has two pipelines: stage and provided
3. Configuration for creation two buckets now added

-============================-

HW#10

1. Stage group servers are launched
2. Ansible folder created with files: ansible.cfg , inventory.yml , requirements.txt
3. Playbook clone.yml to git reddit on app server created
4. Results Q13.2: Two servers checked (ok=2) and applied config to one (changed=1). We have deleted Reddit folder, so Ansible should clone to folder.

-============================-

HW#11

1. Ansible provision changed to module structure - site.yml describes whole provision base and deploy.yml, db.yml, app.yml describes deployment to various VMs
2. Packer provisions Ruby and MongoDB with Ansible

-============================-

HW#12

1. Structure of Ansible folder now:
./ansible/
├── environments
│   ├── prod
│   │   └── group_vars
│   └── stage
│       └── group_vars
├── old
│   ├── files
│   └── templates
├── playbooks
└── roles
    ├── app
    │   ├── defaults
    │   ├── files
    │   ├── handlers
    │   ├── meta
    │   ├── tasks
    │   ├── templates
    │   ├── tests
    │   └── vars
    ├── db
    │   ├── defaults
    │   ├── files
    │   ├── handlers
    │   ├── meta
    │   ├── tasks
    │   ├── templates
    │   ├── tests
    │   └── vars
    └── jdauphant.nginx
        ├── defaults
        ├── handlers
        ├── meta
        ├── tasks
        ├── templates
        ├── test
        └── vars
2. All unused files moved to ansible/old
3. Playbooks moved to ansible/playbooks
4. Ansible structure now includes enviroments and roles
5. Ansible now uses ANSIBLE_VAULT

-============================-

HW#13

1. Packer now uses Ansible roles
2. Made local (VirtualBox) deployment with Vagrant
3. Made tests with Molecule and Testinfra on DataBase VM
4. .gitignore - added Vagrant support

-============================-
