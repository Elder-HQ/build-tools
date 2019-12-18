#!/bin/bash -e

VERSION="$1"

if [ -z "$VERSION" ]; then
  cat >&2 <<EOF
Build, tag and push a new java circle image.

SYNTAX:
  $0 <version>

Example:
  $0 "20191218-1"
EOF
  exit 1
fi

TAG="elderhq/java-circle-image:$VERSION"

echo "Building $TAG..."

set -x
docker build . -t "$TAG"
docker push "$TAG"

echo "Tag $TAG successfully built."
