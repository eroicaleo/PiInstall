#!/bin/bash                                                                                                                   
echo "Start installing..."
HOME_DIR="/home/pi"
# Install modules
if [[ -e ${HOME_DIR}/lib/modules ]]; then
  echo "Install modules..."
  rm -rf /lib/modules_new /lib/modules
  cp -rf ${HOME_DIR}/lib/modules /lib/modules_new
  ln -sf /lib/modules_new /lib/modules
fi

# Install firmware
if [[ -e ${HOME_DIR}/lib/firmware ]]; then
  echo "Install firmware..."
  rm -rf /lib/firmware_new /lib/firmware
  cp -rf ${HOME_DIR}/lib/firmware /lib/firmware_new
  ln -sf /lib/firmware_new /lib/firmware
fi

# Install kernel image
if [[ -e ${HOME_DIR}/lib/Image ]]; then
  echo "Install kernel image..."
  rm -rf /boot/kernel_new.img
  cp -rf ${HOME_DIR}/lib/Image /boot/kernel_new.img
  # edit file in place
  sudo sed -i 's/# kernel=kernel_new.img/  kernel=kernel_new.img/' /boot/config.txt
fi

sync
echo "Install complete!"
