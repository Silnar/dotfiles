#!/bin/bash

# confirm you can access the internet
if [[ ! $(curl -Is http://www.google.com/ | head -n 1) =~ "302 Found" ]]; then
  echo "Your Internet seems broken. Press Ctrl-C to abort or enter to continue."
  read
fi

pacman --noconfirm -S vim


# Install vbox extensions and kernel modules
pacman --noconfirm -S virtualbox-guest-utils virtualbox-guest-modules

# Load vbox modules at boot
cat > /etc/modules-load.d/virtualbox.conf << EOL
vboxguest
vboxsf
vboxvideo
EOL

# Force load vbox modules now
while read module
  do modprobe "$module"
done < /etc/modules-load.d/virtualbox.conf

# Start vboxservice
systemctl enable vboxservice
systemctl start vboxservice
