FROM archlinux:latest

# CachyOS repos for their patches/toolchain
RUN curl -o /tmp/cachyos-repo.tar.xz https://mirror.cachyos.org/repo/x86_64/cachyos/cachyos-keyring-*.pkg.tar.zst && \
    pacman -U --noconfirm /tmp/cachyos-repo.tar.xz

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
    openssh \
    rust

# Kernel source (CachyOS patched)
RUN git clone --depth 1 https://github.com/CachyOS/linux-cachyos.git /usr/src/linux

WORKDIR /usr/src/linux

# Your .config gets mounted or pulled from repo
VOLUME /config

# Entry point for builds
COPY build.sh /build.sh
RUN chmod +x /build.sh

CMD ["/build.sh"]
