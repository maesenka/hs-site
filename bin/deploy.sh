#!/bin/bash
set -o nounset
set -o errexit
set -x
set -e

NFLAG=""

while getopts ":n" opt; do
  case $opt in
    n)
      NFLAG="-n"
      ;;
    \?)
      echo "Invalid option: -$OPTARG" >&2
      ;;
  esac
done

# Set the environment by loading from the file "environment" in the same directory
DIR="$( cd "$( dirname $( dirname "$0" ) )" && pwd)"
echo "$DIR"
source "$DIR/.env"
cat "$DIR/.env"
echo "Deploying ${DIR}/${DEPLOY_SOURCE_DIR} to ${DEPLOY_ACCOUNT}@${DEPLOY_SERVER}:${DEPLOY_DEST_DIR}"

docpad generate --env static
chmod -R og+Xr out
# note that message: "rsync: failed to set permissions on "/var/www/www2.hibernatespatial.org/.": Operation not permitted (1) " can be safely ignored
rsync $NFLAG -e "$SSH" -rvzp --size-only --delete --quiet --exclude-from="$DIR/.deployignore" "${DIR}/${DEPLOY_SOURCE_DIR}" "${DEPLOY_ACCOUNT}@${DEPLOY_SERVER}:${DEPLOY_DEST_DIR}"
