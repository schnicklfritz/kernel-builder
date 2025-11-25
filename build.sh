#!/bin/bash
set -e

# Pull config from mounted volume or git
cp /config/.config .config || curl -o .config https://raw.githubusercontent.com/YOU/kernel-config/main/.config

# Build
make olddefconfig
make CC=clang LLVM=1 LLVM_IAS=1 -j$(nproc)

# Package
make INSTALL_MOD_PATH=/output modules_install
cp arch/x86/boot/bzImage /output/vmlinuz-cachyos-custom

echo "Done! rsync /output back to your machine"
