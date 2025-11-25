FROM archlinux:latest

# Initialize pacman and update
RUN pacman-key --init && \
    pacman -Syu --noconfirm curl

# CachyOS repo setup (official method)
RUN curl -fsSL https://mirror.cachyos.org/cachyos-repo.tar.xz -o /tmp/cachyos-repo.tar.xz && \
    cd /tmp && \
    tar xvf cachyos-repo.tar.xz && \
    cd cachyos-repo && \
    ./cachyos-repo.sh

# Install build dependencies
RUN pacman -Syu --noconfirm \
    base-devel \
    clang \
    llvm \
    lld \
    bc \
    cpio \
    gettext \
    libelf \
    pahole \
    perl \
    python \
    tar \
    xz \
    zstd \
    ccache \
    git \
    rsync \
    openssh

# Kernel source (CachyOS patched)
RUN git clone --depth 1 https://github.com/CachyOS/linux.git /usr/src/linux

WORKDIR /usr/src/linux

# Your .config gets mounted or pulled from repo
VOLUME /config
VOLUME /output

# Entry point for builds
COPY build.sh /build.sh
RUN chmod +x /build.sh

CMD ["/build.sh"]
