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

cd ${module_dir}
cp ${kernel_dir}/arch/arm/boot/Image ${module_dir}/lib
binary_new="binary_new.tar.gz"
tar -czvf ${binary_new} ./lib
scp ${binary_new} pi@192.168.1.10:${binary_new}
