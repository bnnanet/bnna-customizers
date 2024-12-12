#!/bin/sh
set -e
set -u
set -x

#
# ./etc/apk/world
#
apk --no-cache update
apk --no-cache add sudo openssh libcap logrotate
apk --no-cache add curl fish git htop less screen vim wget xz unzip
rc-update add sshd
rc-update add firstboot

#
# 'app' user w/ sudo
#
if ! test -d /home/app; then
    adduser -D -s /bin/ash -g '' 'app' app
    adduser app wheel
fi
sed -i 's/app:!/app:*/' /etc/shadow
echo "app ALL=(ALL:ALL) NOPASSWD: ALL" | tee "/etc/sudoers.d/app"
chmod 0600 /etc/sudoers.d/app
#vi /etc/sudoers.d/app
