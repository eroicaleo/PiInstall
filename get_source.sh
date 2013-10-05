#!/bin/bash                                                                                                                   

script_dir=$( pwd )
proj_dir=$(dirname ${script_dir})
kernel_dir="${proj_dir}/kernel"
tool_dir="${proj_dir}/tools"

if [[ ! -e ${kernel_dir} ]]; then
  echo "Not found kernel source! Will download it for you!"
  mkdir ${kernel_dir}
  cd ${kernel_dir}
  git init
  git fetch git://github.com/raspberrypi/linux.git rpi-3.6.y:refs/remotes/origin/rpi-3.6.y
  git checkout rpi-3.6.y
fi

if [[ ! -e ${tool_dir} ]]; then
  echo "Not found cross-compiler tool! Will download it for you!"
  cd ${proj_dir}
  git clone git://github.com/raspberrypi/tools.git
fi

echo "Done! You are good to go!"
