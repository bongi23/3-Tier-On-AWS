#!/bin/bash

terraform apply

python3 get_servers_ip.py -p serverless-personal -t Role=WebServer

ansible-playbook -i inventory.ini ../config/playbooks/db/main.yml --user ec2-user

python3 initRS.py -i inventory.ini -rs satispay-repl

ansible-playbook -i inventory.ini ../config/playbooks/app/main.yml --user ec2-user

ansible-playbook -i inventory.ini ../config/playbooks/web/main.yml --user ec2-user
