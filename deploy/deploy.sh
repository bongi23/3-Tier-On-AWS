#!/bin/bash

# modify this constants if needed:
PLAYBOOK_PATH="../config/playbooks"
PYTHON_VENV_PATH="./venv"
TERRAFORM_MAIN_PATH="../"

AWS_PROFILE=$1
AWS_REGION=$2
REPL_SET_NAME=$3

#### CHECK AWS SETTINGS
if [ -z "${AWS_PROFILE}" ]
then
  echo "ERROR: you should specify an AWS profile as a first argument..."
  exit 1
fi
if [ -z "${AWS_REGION}" ]
then
  AWS_REGION="eu-central-1"
  echo "Using default region eu-central-1."
fi
####


#### CHECK MONGO SETTINGS
# If a name for the replica set has not been specified, use a default one!
if [ -z "${REPL_SET_NAME}" ]
then
  REPL_SET_NAME="satispay-repl"
  echo "Using default replica set name: ${REPL_SET_NAME}."
fi
# Check that the replica set name specified is the same in the mongod.conf
check_repl_set_name="$(grep -c "[[:blank:]]replSetName:[[:blank:]]${REPL_SET_NAME}" "${PLAYBOOK_PATH}/db/mongod.conf")"
if [[ "${check_repl_set_name}" -eq 0 ]]
then
  echo "ERROR: replicaset name specified does not match the one in ${PLAYBOOK_PATH}/db/mongod.conf"
fi
####

#### Start deploy!
echo "Starting deploy!"
PREC_DIR="$(pwd)"
cd "${TERRAFORM_MAIN_PATH}" && terraform init && terraform apply
if [[ $? -ne 0 ]]
then
  echo "A problem occurred while deploying. Exiting..."
  exit 1
fi
cd "${PREC_DIR}"

echo "Retrieving IP addresses for the deployed EC2..."
source "${PYTHON_VENV_PATH}/bin/activate"
python3 get_servers_ip.py -p "${AWS_PROFILE}" -t "Role=WebServer" -r "${AWS_REGION}" # creates two files, inventory.ini (it will be used by ansible) and private_ip (it will be used by mongo playbook)
if [[ $? -ne 0 ]]
then
  echo "A problem occurred while retrieving IP address. Exiting..."
  exit 1
fi
deactivate


echo "Ready to config server!"
export ANSIBLE_HOST_KEY_CHECKING=false

ansible-playbook -i inventory.ini "${PLAYBOOK_PATH}/db/main.yml" --user ec2-user
if [[ $? -ne 0 ]]
then
  echo "A problem occurred while configuring DB. Exiting..."
  exit 1
fi

echo "Configuring app layer..."
ansible-playbook -i inventory.ini "${PLAYBOOK_PATH}/app/main.yml" --user ec2-user
if [[ $? -ne 0 ]]
then
  echo "A problem occurred while configuring app service. Exiting..."
  exit 1
fi

echo "Configuring web layer..."
ansible-playbook -i inventory.ini "${PLAYBOOK_PATH}/web/main.yml" --user ec2-user
if [[ $? -ne 0 ]]
then
  echo "A problem occurred while configuring web service. Exiting..."
  exit 1
fi

RC=$(./tests.sh)
if [[ $RC -ne 0 ]]
then
  echo "A problem occurred while executing tests!"
  exit 1
fi

exit 0
