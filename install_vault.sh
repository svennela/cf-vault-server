#!/usr/bin/env bash

###########################################################################
# Download and Install Vault                                              #
###########################################################################

set -o errexit

VAULT_OSS="${VAULT_OSS:-1.4.0}"
UNAME=linux_amd64
VERBOSE=false
VAULT_DIRECTORY=vault
DOWNLOAD_DIRECTORY=download
readonly script_name="$(basename "${BASH_SOURCE[0]}")"

function initialize() {
  # cleanup
  mkdir -p ${VAULT_DIRECTORY}
  mkdir -p ${DOWNLOAD_DIRECTORY}
}


function unpack() {

  cd ${VAULT_DIRECTORY}

  if [[ -f vault ]]; then
    rm vault
  fi

  say "Unzipping ${VAULT_FILE}..."
  if [[ ${VERBOSE} == true ]]; then
    unzip "../${DOWNLOAD_DIRECTORY}/${VAULT_FILE}"
  else
    unzip -q "../${DOWNLOAD_DIRECTORY}/${VAULT_FILE}"
  fi

  chmod a+x vault

  cd ..
}

function download() {

  if [[ ! -f "${DOWNLOAD_DIRECTORY}/${VAULT_FILE}" ]]; then
    cd ${DOWNLOAD_DIRECTORY}
    # install Vault
    say "Downloading Vault from ${VAULT_URL}"
    if [[ ${VERBOSE} == true ]]; then
      wget "${VAULT_URL}" -O "${VAULT_FILE}"
    else
      wget "${VAULT_URL}" -q -O "${VAULT_FILE}"
    fi

    if [[ $? != 0 ]]; then
      echo "Cannot download Vault"
      exit 1
    fi
    cd ..
  fi
}


function download_vault() {

  VAULT_VER="${VAULT_VER:-${VAULT_OSS}}"
  VAULT_ZIP="vault_${VAULT_VER}_${UNAME}.zip"
  VAULT_FILE=${VAULT_ZIP}
  VAULT_URL="https://releases.hashicorp.com/vault/${VAULT_VER}/${VAULT_ZIP}"
  initialize
  download
  unpack
}



download_vault