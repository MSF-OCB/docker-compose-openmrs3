#! /usr/bin/env nix-shell
#! nix-shell -i bash --packages docker-compose

set -e

environment="$1"

echo "Generating the openmrs3-emr-"${environment}" environment(.env) file..."

./deploy/generateenv.sh ${environment}

if [ ! -d "./backup-data" ]
then
   mkdir ./backup-data
fi

#chmod -vR a=r-wx,u=wr,a+X *
chmod -vR a=r-wx,u=wr,a+X distro/*

echo "Pulling latest image from ${MSFOCB_DEPLOY_DIR}..."

docker-compose --verbose --project-directory "${MSFOCB_DEPLOY_DIR}" --ansi never --file "${MSFOCB_DEPLOY_DIR}/docker-compose-o3.yml" pull


echo "Starting the openmrs3-emr-${environment} environment..."

echo "Changing ownership of /openmrs and /usr/local/tomcat to 1001:0..."
docker-compose --verbose --project-directory "${MSFOCB_DEPLOY_DIR}" --ansi never --file "${MSFOCB_DEPLOY_DIR}/docker-compose-o3.yml" run -u 0 --rm  backend chown -R 1001:0 /openmrs

docker-compose --verbose --project-directory "${MSFOCB_DEPLOY_DIR}" --ansi never --file "${MSFOCB_DEPLOY_DIR}/docker-compose-o3.yml" run -u 0 --rm  backend chown -R 1001:0 /usr/local/tomcat


echo "Done."
