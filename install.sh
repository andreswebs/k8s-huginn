#!/usr/bin/env bash

set -o errexit
set -o pipefail
set -o nounset

ENV_FILE=".env"

THIS_ENV=$(grep -Ev '^#' "${ENV_FILE}" | xargs)

TEMPLATE_DIR="templates"
MANIFEST_DIR="manifests"
TEMPLATE_SUFFIX=".tpl"

# _generate_config $THIS_ENV $TEMPLATE_NAME $CONFIG_NAME
function _generate_config {
  local ENV_FILE="${1}"
  local TEMPLATE_NAME="${2}"
  local CONFIG_NAME="${3}"
  eval "${THIS_ENV}" envsubst < "${TEMPLATE_NAME}" > "${CONFIG_NAME}"
}

function _apply {
  local MANIFEST="${1}"
  kubectl apply -f "${MANIFEST}"
}

DATABASE_USERNAME="postgres"
DATABASE_PASSWORD=$(echo -n "$(pwgen 16 1)")
POSTGRES_USER="${DATABASE_USERNAME}"
POSTGRES_PASSWORD="${DATABASE_PASSWORD}"

HUGINN_INVITATION_CODE=$(echo -n "$(pwgen 32 1)")

THIS_ENV="${THIS_ENV} DATABASE_USERNAME=${DATABASE_USERNAME} DATABASE_PASSWORD=${DATABASE_PASSWORD} POSTGRES_USER=${POSTGRES_USER} POSTGRES_PASSWORD=${POSTGRES_PASSWORD} HUGINN_INVITATION_CODE=${HUGINN_INVITATION_CODE}"

for template in "${TEMPLATE_DIR}"/*; do
  manifest="${MANIFEST_DIR}/$(basename "${template}" "${TEMPLATE_SUFFIX}")"
  _generate_config "${THIS_ENV}" "${template}" "${manifest}"
done

_apply "${MANIFEST_DIR}/huginn-namespace.yml"
_apply "${MANIFEST_DIR}/huginn-db-secret.yml"
_apply "${MANIFEST_DIR}/huginn-server-secret.yml"
_apply "${MANIFEST_DIR}/huginn-invitation-secret.yml"
_apply "${MANIFEST_DIR}/huginn-db.yml"
_apply "${MANIFEST_DIR}/huginn-server.yml"

rm "${MANIFEST_DIR}/huginn-db-secret.yml"
rm "${MANIFEST_DIR}/huginn-server-secret.yml"
rm "${MANIFEST_DIR}/huginn-invitation-secret.yml"
