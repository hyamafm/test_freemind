#!/bin/bash

# Build frontend resources.
DOCKER_CMD='docker run --rm -t -v "$PWD":/data test dep deploy'
eval "$DOCKER_CMD $TARGET_ENV"
exit 0
