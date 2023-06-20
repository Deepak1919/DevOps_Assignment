# DevOps_Assignment
Q1: Write a Terraform script to provision the EKS cluster in the EU-west-2 region.
1. configure the AWS CLI account in your Windows and Linux OS.
2. After that, run the below-mentioned Terraform command inside the Terraform_Script_For_EKS directory.
   #terraform init
   #terraform plan
   #terraform apply
3. After running all commands, go to the AWS account and check in the London EU-WESt-2 region that the EKS (Elastic Kubernetes Services) cluster has been created.


Q1:-Write an Ansible script to install Docker and setuptools using dynamic inventory?
1. Install the Ansible package on the Linux server.
2. Clone the https://github.com/Deepak1919/DevOps_Assignment.git
3. Go to the Ansible_Script_For_dockerANDsetuptools directory and find the playbook.yml file and inventory.ini.
4. In the inventory.ini file, add the slave system ip, username, and location of the ssh id_rsa file.
5. Now run the below command.
   # ansible-playbook -i inventory.ini playbook.yml
6. After completing this command, go to the slave side and check that Doker and setuptools have been installed.


Q3:-Write a docker-compose script to deploy two microservice orders and billings using python flask, redis and kafka?
1. First, clone the repository in the Ubuntu system.
2. Go inside the docker-compose directory and run the below command. Make sure the docker-compose services are installed on your Ubuntu server.
  # docker-compose up -d
3. After completing this command, you need to run the docker ps -a command and check that the microservices have been deployed.  