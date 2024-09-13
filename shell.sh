#!/bin/bash
##
# Opens a Bash shell in a meson-minimal-ti-c28x-cgt:0.1.0 Docker container.
# 

echo 
echo "Open Shell in Docker Container"
echo "============================================================"
echo

echo "Org: engjay"
echo "Image: meson-minimal-ti-c28x-cgt"
echo "Version: 0.1.0"

echo

# Open a bash shell in a container.
#
docker run -it -v .:/repo ghcr.io/engjay/meson-minimal-ti-c28x-cgt:0.1.0 /bin/bash

echo
