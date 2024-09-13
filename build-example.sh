#!/bin/bash
##
# Build the example in a meson-minimal-ti-c28x-cgt:0.1.0 Docker container.
# 

docker run -it -v .:/repo ghcr.io/engjay/meson-minimal-ti-c28x-cgt:0.1.0 /bin/bash -c "cd repo && meson setup builddir --cross=c2000.txt && meson compile -C builddir --verbose"
