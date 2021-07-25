# Configuration

In this folder you can find all the configuration management part.

## Playbooks

In the Playbooks folder, there are 3 ansible playbooks: app, web and db (one per layer.)

### Web server

The *web* playbook (./playbooks/web/main.yml) executes the following tasks:
1. Installs the ***nginx*** web server
2. copies web server microservice source code to the remote hosts
3. installs microservice dependencies
4. configures nginx
5. starts the service

### App server

The *app* (./playbooks/app/main.yml) playbook executes the following tasks:
1. Installs the ***nginx unit*** application server
2. copies app server microservice source code to the remote hosts
3. installs microservice dependencies
4. configures nginx unit
5. starts the service

### DB server

The *db* (./playbooks/db/main.yml) playbook executes the following tasks
1. installs MongoDB
2. configures Mongo as a 3 member replicaset
3. starts the db
4. init the replicaset (run only in one node)