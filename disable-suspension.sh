#!/bin/bash

# Ensure the script is run as root
if [ "$(id -u)" -ne 0 ]; then
    echo "This script must be run as root" 1>&2
    exit 1
fi

# Create and enable systemd service to prevent suspension
cat <<EOF >/etc/systemd/system/disable-suspend.service
[Unit]
Description=Prevent suspend
Before=sleep.target

[Service]
Type=oneshot
ExecStart=/usr/bin/systemctl mask sleep.target suspend.target hibernate.target hybrid-sleep.target

[Install]
WantedBy=multi-user.target
EOF

# Enable and start the newly created service
systemctl enable disable-suspend.service
systemctl start disable-suspend.service

# Backup the original logind.conf before making changes
cp /etc/systemd/logind.conf /etc/systemd/logind.conf.bak

# Modify /etc/systemd/logind.conf to ignore suspend, lid switch, and hibernate
sed -i '/^#HandleSuspendKey=suspend$/c\HandleSuspendKey=ignore' /etc/systemd/logind.conf
sed -i '/^#HandleLidSwitch=suspend$/c\HandleLidSwitch=ignore' /etc/systemd/logind.conf
sed -i '/^#HandleHibernateKey=hibernate$/c\HandleHibernateKey=ignore' /etc/systemd/logind.conf

# Restart systemd-logind to apply changes
systemctl restart systemd-logind.service

echo "System suspension has been successfully disabled."
