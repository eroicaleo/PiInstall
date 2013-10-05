#!/bin/bash                                                                                                                   

script_dir=$( pwd )
proj_dir=$(dirname ${script_dir})
kernel_dir="${proj_dir}/kernel"
tool_dir="${proj_dir}/tools"
module_dir="${proj_dir}/modules"

if [[ ! -e ${kernel_dir} ]]; then
  echo "Not found kernel source! Exit!"
  exit 66
fi

cd ../kernel
export CCPREFIX="${tool_dir}/arm-bcm2708/arm-bcm2708-linux-gnueabi/bin/arm-bcm2708-linux-gnueabi-"
echo $CCPREFIX

# Linaro toolchain
# export CCPREFIX="${tool_dir}/arm-bcm2708/gcc-linaro-arm-linux-gnueabihf-raspbian/bin/arm-linux-gnueabihf-"

make ARCH=arm CROSS_COMPILE=${CCPREFIX} -j5 modules

export MODULES_TEMP="${module_dir}"

make ARCH=arm CROSS_COMPILE=${CCPREFIX} INSTALL_MOD_PATH=${MODULES_TEMP} modules_install
