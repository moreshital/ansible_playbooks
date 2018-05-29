#!/bin/bash
export GCE_PROJECT=sumoplus-1181
export GCE_PEM_FILE_PATH=/Users/deepakdalavi/Downloads/SumoPlus-default.json
export GCE_EMAIL=$(grep client_email $GCE_PEM_FILE_PATH | sed -e 's/  "client_email": "//g' -e 's/",//g')
gcloud config set project $GCE_PROJECT
export GCE_INI_PATH=/Users/deepakdalavi/devops-internal/shine_poc/ansible_playbooks/mongo_cluster_setup/inventory
