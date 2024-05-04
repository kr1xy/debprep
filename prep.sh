#/bin/bash

# check for root
if [ "$(id -u)" -ne 0 ]; then
    echo "Please run me as root."
    exit 1
fi

echo "Checking that cloud-init is installed ..."
apt install -y cloud-init

echo "Removing SSH host keys ..."
rm /etc/ssh/ssh_host_*

echo "Resetting machine ID ..."
truncate -s 0 /etc/machine-id

echo "Checking if /var/lib/dbus/machine-id is sym-linked to /etc/machine-id ..."
if [ ! -h /var/lib/dbus/machine-id ]; then
    echo "Sym-linking machine ID to /var/lib/dbus/machine-id ..."
    ln -s /etc/machine-id /var/lib/dbus/machine-id
else
    echo "It is. Not doing anything."
fi

echo "Cleaning out apt ..."
apt clean -y && apt autoremove -y



