#!/bin/sh -e

. ./config.sh

rm -rf build

mkdir -p build && cd build

# Build the image and mount it
fallocate -l10G image
echo "n
p
1


w
" | fdisk image > /dev/null 
loopd=$(losetup -P -f --show image)
mkfs.ext4 "$loopd"p1
mkdir mnt
mount "$loopd"p1 mnt

# Create a basic filesystem
for d in usr bin sbin usr/bin usr/sbin dev etc home lib mnt opt proc srv sys \
             var/lib var/lock var/log var/run var/spool usr/include usr/lib \
             usr/share usr/src boot tools; do
    mkdir -p "mnt/$d"
done
install -d -m 0750 mnt/root
install -d -m 1777 mnt/tmp

root="$PWD"

for prog in kernel busybox musl make binutils; do
    "../$prog.sh" "$root/mnt"
    cd "$root"
done

# Install files to the base system
install -Dm755 ../../files/udhcpc.script mnt/usr/share/udhcpc/default.script
cp ../../files/* mnt/etc

# Install the bootloader
grub-install --modules=part_msdos \
             --target=i386-pc \
             --boot-directory="$PWD/mnt/boot" \
             "$loopd"

uid=$(fdisk -l image | grep "Disk identifier")
uid=${uid##Disk identifier: 0x}

cat <<EOF > mnt/boot/grub/grub.cfg
linux /boot/bzImage quiet init=/bin/sh root=PARTUUID=$uid
boot
EOF

umount mnt

unset CFLAGS
unset LDFLAGS
unset MAKEFLAGS
