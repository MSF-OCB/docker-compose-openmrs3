#! /usr/bin/env nix-shell
#! nix-shell -i bash --packages bash

set -e
FILE=.env
if [[ -f "$FILE" ]]
then
    rm -f "$FILE"
fi

configfile="${MSFOCB_CONFIGS_DIRECTORY}/kunduz-$1-configs"
secretfile="${MSFOCB_SECRETS_DIRECTORY}/kunduz-$1-secrets"

function getprop {
    grep "${1}" ${configfile} | cut -d'=' -f2
}

function getsec {
    grep "${1}" ${secretfile} | cut -d'=' -f2
}
echo "COMPOSE_PROJECT_NAME=bahmni_distro_kunduz_$1" >> "$FILE"
echo "BAHMNI_ENV=$1" >> "$FILE"
echo "DBBK_BACKUP_NAME=Bahmni_Kunduz_$1_Backup" >> "$FILE"
echo "BAHMNI_DOMAIN=$(getprop 'BAHMNI_DOMAIN')" >> "$FILE"
echo "BAHMNI_GLOBAL_DOMAIN=$(getprop 'BAHMNI_GLOBAL_DOMAIN')" >> "$FILE"
echo "EMR_REPORTS_DOMAIN=$(getprop 'EMR_REPORTS_DOMAIN')" >> "$FILE"
echo "EMR_VERSION_TAG=$(getprop 'EMR_VERSION_TAG')" >> "$FILE"
echo "METABASE_POSTGRES_IMAGE_TAG=$(getprop 'METABASE_POSTGRES_IMAGE_TAG')" >> "$FILE"
echo "METABASE_IMAGE_TAG=$(getprop 'METABASE_IMAGE_TAG')" >> "$FILE"
echo "BAHMNI_MART_DB_IMAGE_TAG=$(getprop 'BAHMNI_MART_DB_IMAGE_TAG')" >> "$FILE"
echo "BAHMNI_MART_IMAGE_TAG=$(getprop 'BAHMNI_MART_IMAGE_TAG')" >> "$FILE"
echo "OPENELIS_DB_NAME=$(getprop 'OPENELIS_DB_NAME')" >> "$FILE"
echo "PG_REPLICATION_SLOT_NAME=$(getprop 'PG_REPLICATION_SLOT_NAME')" >> "$FILE"
echo "MART_CRON_TIME=$(getprop 'MART_CRON_TIME')" >> "$FILE"
echo "METABASE_DB_NAME=$(getprop 'METABASE_DB_NAME')" >> "$FILE"
echo "METABASE_DB_USER=$(getprop 'METABASE_DB_USER')" >> "$FILE"
echo "METABASE_DB_PASSWORD=$(getsec 'METABASE_DB_PASSWORD')" >> "$FILE"
echo "MART_DB_NAME=$(getprop 'MART_DB_NAME')" >> "$FILE"
echo "MART_DB_USERNAME=$(getprop 'MART_DB_USERNAME')" >> "$FILE"
echo "MART_DB_PASSWORD=$(getsec 'MART_DB_PASSWORD')" >> "$FILE"
