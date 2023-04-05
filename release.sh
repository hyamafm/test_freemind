#!/bin/bash

if [[ $# -ne 1 ]]; then
  echo 'Usage: ./release.sh {staging|production}'
  exit 1
fi

TARGET_ENV=$1
if [ "$TARGET_ENV" != 'staging' ] && [ "$TARGET_ENV" != 'production' ]; then
  echo 'Target must be "staging" or "production"'
  echo 'Abort!'
  exit 1
fi

if [ "$TARGET_ENV" == 'production' ]; then
  read -p "[DEPLOY] Do you really want to deploy in production environment? (y/N): " input
  case "$input" in
    [yY]*) ;;
    *) echo 'abort.' ; exit 1 ;;
  esac
  read -p "Type 'DEPLOY TO PRODUCTION' to continue: " input
  case "$input" in
    'DEPLOY TO PRODUCTION') ;;
    *) echo 'abort.' ; exit 1 ;;
  esac
fi

# Build frontend resources.
docker run -it --rm -v "$PWD/../../":/app -w /app/tools/deployer node:18.2.0 npm install && npm run build_${TARGET_ENV}

DOCKER_CMD='/usr/local/bin/docker run --rm -t -v "$PWD":/data -v /run/host-services/ssh-auth.sock:/tmp/ssh-agent.sock --env SSH_AUTH_SOCK=/tmp/ssh-agent.sock wc-deployer dep deploy'
eval "$DOCKER_CMD $TARGET_ENV"
exit 0
