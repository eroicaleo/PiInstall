#!/bin/bash                                                                                                                   
echo "Start restoring..."

  echo "Restoring modules..."
  rm -rf /lib/modules
  ln -sf /lib/modules_orig /lib/modules

  echo "Restoring firmware..."
  rm -rf /lib/firmware
  ln -sf /lib/firmware_orig /lib/firmware

# restoring kernel image
  echo "Restoring kernel image..."
  # edit file in place
  sed -i 's/  kernel=kernel_new.img/# kernel=kernel_new.img/' /boot/config.txt

sync
echo "Restore complete!"
