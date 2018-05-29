export GCE_PROJECT=sumoplus-1181
export GCE_PEM_FILE_PATH=/home/ubuntu/SumoPlus-default.json
export GCE_EMAIL=$(grep client_email $GCE_PEM_FILE_PATH | sed -e 's/  "client_email": "//g' -e 's/",//g')
gcloud config set project $GCE_PROJECT
