#!/usr/bin/env sh

set -eu
set -o pipefail

############################################################
export USERNAME=${USERNAME:-gbennett}
export PASSWORD="$1"

security add-generic-password -a ${USER} -s "${USERNAME}" -w "${PASSWORD}"
