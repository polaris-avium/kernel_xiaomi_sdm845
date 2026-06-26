#!/bin/bash
set -e
export PATH=~/kernel/toolchains/clang/bin:$PATH
export ARCH=arm64
export SUBARCH=arm64
export CROSS_COMPILE=~/kernel/toolchains/aarch64-linux-android-4.9/bin/aarch64-linux-android-
export CROSS_COMPILE_ARM32=~/kernel/toolchains/arm-linux-androideabi/bin/arm-linux-androideabi-
export CLANG_TRIPLE=aarch64-linux-gnu-

echo "=== Generating config ==="
make O=out ARCH=arm64 vendor/sdm845-perf_defconfig vendor/xiaomi/polaris.config vendor/xiaomi/sdm845-common.config 2>&1

echo "=== Starting build ==="
make O=out   CC="ccache clang"   LD=ld.lld   NM=llvm-nm   OBJDUMP=llvm-objdump   STRIP=llvm-strip   -j$(nproc) 2>&1

echo "=== Build complete ==="
