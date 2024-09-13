FROM ubuntu:22.04

LABEL org.opencontainers.image.source="https://github.com/EngJay/meson-minimal-ti-c28x-cgt"
LABEL org.opencontainers.image.description="Minimal Meson build example for TI C28x CGT"
LABEL org.opencontainers.image.version="0.1.0"
LABEL org.opencontainers.image.documentation="https://github.com/EngJay/meson-minimal-ti-c28x-cgt/README.md"

SHELL ["/bin/bash", "-o", "pipefail", "-c"]

# Set time zone to UTC.
ARG TZ=UTC
RUN ln -sf /usr/share/zoneinfo/$TZ /etc/localtime

# Initially update the package lists and install gpg, which is needed for adding the git-core ppa.
RUN apt-get update && \
    apt-get install -y gnupg

ENV PYTHON_PIP_VER 22.0.2+dfsg-1ubuntu0.4

# Update and upgrade OS, then install deps.
# hadolint ignore=DL3008
RUN sed -i 's/# \(.*multiverse$\)/\1/g' /etc/apt/sources.list && \
    apt-get update && \
    apt-get install --no-install-recommends -y software-properties-common && \
    add-apt-repository ppa:git-core/ppa && \
    apt-get update && \
    apt-get -y upgrade && \
    apt-get install --no-install-recommends -y apt-utils && \
    apt-get install --no-install-recommends -y lbzip2 build-essential lsb-release wget curl git && \
    apt-get install --no-install-recommends -y libpcre3 libpcre3-dev autotools-dev automake && \
    apt-get install --no-install-recommends -y python3-pip=${PYTHON_PIP_VER} && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/*

# Create location for downloads.
ENV DOWNLOAD_DIR=/root/Downloads
RUN mkdir ${DOWNLOAD_DIR}

# Match TI's env var for products dir on Linux.
ENV TI_PRODUCTS_DIR /root/ti

# Add dir for TI compilers.
ENV TI_COMPILERS_DIR ${TI_PRODUCTS_DIR}/cgt
RUN mkdir -p ${TI_COMPILERS_DIR}

# Install TI C2000 Code Gen Tools.
ENV TI_C2000_CGT_VER=22.6.1.LTS
ENV TI_C2000_CGT_INSTALLED_DIR=ti-cgt-c2000_${TI_C2000_CGT_VER}
ENV TI_C2000_CGT_FILE=ti_cgt_c2000_${TI_C2000_CGT_VER}_linux-x64_installer.bin
COPY deps/${TI_C2000_CGT_FILE} ${DOWNLOAD_DIR}
RUN chmod +x ${DOWNLOAD_DIR}/${TI_C2000_CGT_FILE}

# Workaround for issue with TI installer.
#
# The installer reports that it doesn't recognize the --prefix option anymore
# and it requires a --installdir option. When setting --installdir, however, the
# passed in path is ignored and the CGT is installed to the directory from which
# the installer was run. To get the installer to install where we want it to, we
# run the installer from the TI_COMPILERS_DIR.
# 
WORKDIR ${TI_COMPILERS_DIR}

# The --installdir option appears to have no effect, see the workaround above.
RUN ${DOWNLOAD_DIR}/${TI_C2000_CGT_FILE} \
    --mode unattended \
    --installdir . && \
    rm -rf ${DOWNLOAD_DIR}/${TI_C2000_CGT_FILE}
ENV PATH="${TI_COMPILERS_DIR}/${TI_C2000_CGT_INSTALLED_DIR}/bin/:${PATH}"

# Return to root as working dir after workaround for TI CGT installer.
# 
WORKDIR /

# Install python deps.
# 
ENV MESON_VER 1.5.1
ENV NINJA_VER 1.11.1.1
ENV PIP_VER 24.2
RUN python3 -m pip install --no-cache-dir pip==${PIP_VER} && \
    python3 -m pip install --no-cache-dir \
    meson==${MESON_VER} \
    ninja==${NINJA_VER}

# Set bash as the default command.
CMD ["/bin/bash"]
