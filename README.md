# Kernel Builder

Docker image for building custom CachyOS kernels on cloud GPU instances (QuickPod, RunPod, etc.)

## Features

- CachyOS patched kernel source
- Clang/LLVM + LTO support
- BORE scheduler ready
- Optimized for fast remote builds

## Usage

### Build the image locally
```bash
docker build -t kernel-builder .
```

### Or pull from DockerHub
```bash
docker pull schnicklfritz/kernel-builder:latest
```

### Run a build
```bash
docker run -v $(pwd)/configs:/config -v $(pwd)/output:/output kernel-builder
```

### Custom .config
Place your `.config` in the `configs/` directory before running.

## Targets

- **CPU:** Intel Haswell (MHASWELL)
- **Scheduler:** BORE
- **LTO:** Full (Clang)
- **Mitigations:** Disabled

## Output

After build completes:
- `output/vmlinuz-cachyos-custom` — Kernel image
- `output/lib/modules/<version>/` — Modules

rsync back to your machine:
```bash
rsync -avz output/ user@laptop:/boot/
```
