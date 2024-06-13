#! /usr/bin/env nix-shell
#! nix-shell -i bash --packages docker-compose

set -e

environment="$1"

echo "Generating the emr-"${environment}" environment(.env) file..."

./deploy/generateenv.sh ${environment}

if [ ! -d "./backup-data" ] 
then
   mkdir ./backup-data
fi

chmod -vR a=r-wx,u=wr,a+X *
chmod -vR a=r-wx,u=wr,a+X properties/*
chmod -vR a=r-wx,u=wr,a+X sqls/*

echo "Pulling latest image from ${MSFOCB_DEPLOY_DIR}..."

docker-compose --verbose --project-directory "${MSFOCB_DEPLOY_DIR}" --ansi never --file "${MSFOCB_DEPLOY_DIR}/docker-compose-db.yml" --file "${MSFOCB_DEPLOY_DIR}/docker-compose-apps.yml" pull

echo "Done."
