FROM archlinux:latest

# Initialize pacman and update
RUN pacman-key --init && \
    pacman -Sy --noconfirm archlinux-keyring && \
    pacman -Syu --noconfirm curl tar

# CachyOS repo setup (non-interactive)
RUN curl -fsSL https://mirror.cachyos.org/cachyos-repo.tar.xz -o /tmp/cachyos-repo.tar.xz && \
    cd /tmp && \
    tar xvf cachyos-repo.tar.xz && \
    cd cachyos-repo && \
    yes | ./cachyos-repo.sh

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

VOLUME /config
VOLUME /output

COPY build.sh /build.sh
RUN chmod +x /build.sh

CMD ["/build.sh"]
