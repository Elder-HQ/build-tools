#!/bin/bash -e

VERSION_BASE=$(date +'%Y%m%d')
PREVIOUS_ATTEMPT=$(docker image ls elderhq/jupyter-circle-image | grep $VERSION_BASE | sort -r | awk '{print $2}' | head -n 1 | awk -F - '{print $2}')

if [ -z "$PREVIOUS_ATTEMPT" ]; then
  PREVIOUS_ATTEMPT=0
fi

CURRENT_ATTEMPT=$[ $PREVIOUS_ATTEMPT + 1 ]
SUGGESTED_VERSION=$VERSION_BASE-$CURRENT_ATTEMPT

read -p "New version number? Suggested is $SUGGESTED_VERSION (Leave blank to use): " VERSION
VERSION=${VERSION:-$SUGGESTED_VERSION}
echo $VERSION

docker build . -t elderhq/jupyter-circle-image:$VERSION

docker push elderhq/jupyter-circle-image:$VERSION

echo ""
echo "Successfully built and pushed elderhq/jupyter-circle-image:$VERSION"
