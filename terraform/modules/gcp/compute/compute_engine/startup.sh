#!/bin/bash
    devices=$(lsblk | grep -E '^sd[^a]|^nvme0n[^1]' | awk '{print $1}')
    c=1
    for d in $devices; do
        mkfs -t ext4 "/dev/$d"
        mount_point="/mnt/data$c"
        mkdir -p "$mount_point"
        echo "/dev/$d $mount_point ext4 defaults 0 0" >> /etc/fstab # Auto mount
        ((c++))
    done
    mount -a # Reload fstab
    for ((i = 1; i < c; i++)); do
      rm -rf "/mnt/data$i"/* # For remove dir lost+found
    done

##install promtail 
# install zip
sudo apt update && apt install zip net-tools -y 

