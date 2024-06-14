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

chmod -vR a=r-wx,u=wr,a+X *
chmod -vR a=r-wx,u=wr,a+X distro/*

echo "Pulling latest image from ${MSFOCB_DEPLOY_DIR}..."

docker-compose --verbose --project-directory "${MSFOCB_DEPLOY_DIR}" --ansi never --file "${MSFOCB_DEPLOY_DIR}/docker-compose-o3.yml" pull

echo "Done."
