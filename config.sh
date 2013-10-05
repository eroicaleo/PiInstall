#!/bin/bash

script_dir=$( pwd )
proj_dir=$(dirname ${script_dir})
kernel_dir="${proj_dir}/kernel"
tool_dir="${proj_dir}/tools"

if [[ ! -e ${kernel_dir} ]]; then
  echo "Not found kernel source! Exit!"
  exit 66
fi

cd ../kernel
export CCPREFIX="${tool_dir}/arm-bcm2708/arm-bcm2708-linux-gnueabi/bin/arm-bcm2708-linux-gnueabi-"
echo $CCPREFIX

# CFLAG="--sysroot"                                                                                                           

# Linaro toolchain
# export CCPREFIX="${tool_dir}/arm-bcm2708/gcc-linaro-arm-linux-gnueabihf-raspbian/bin/arm-linux-gnueabihf-"

if [[ ! -e .config ]]; then
  cp arch/arm/configs/bcmrpi_defconfig .config
fi

make ARCH=arm CROSS_COMPILE=${CCPREFIX} menuconfig
