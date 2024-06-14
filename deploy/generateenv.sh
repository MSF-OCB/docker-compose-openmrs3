#! /usr/bin/env nix-shell
#! nix-shell -i bash --packages bash

set -e
FILE=.env
if [[ -f "$FILE" ]]
then
    rm -f "$FILE"
fi

configfile="${MSFOCB_CONFIGS_DIRECTORY}/openmrs3-$1-configs"

function getprop {
    grep "${1}" ${configfile} | cut -d'=' -f2
}

echo "COMPOSE_PROJECT_NAME=openmrs3_$1" >> "$FILE"
echo "OPENMRS_ENV=$1" >> "$FILE"
echo "OPENMRS_DOMAIN=$(getprop 'OPENMRS_DOMAIN')" >> "$FILE"