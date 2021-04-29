#!/bin/sh -e

. ./config.sh

init_image() {
    # Clean previous image
    rm -rf output
    mkdir output
    mkdir output/mnt

    # Create a basic filesystem
    for d in usr bin sbin usr/bin usr/sbin dev etc home lib mnt opt proc srv \
                 sys var/lib var/lock var/log run var/run var/spool \
                 usr/include usr/lib usr/share usr/src boot tools; do
        mkdir -p "output/mnt/$d"
    done
    install -d -m 0750 output/mnt/root
    # Install files to the base system
    install -Dm755 files/udhcpc.script \
            output/mnt/usr/share/udhcpc/default.script
    cp files/* output/mnt/etc
    mkdir output/mnt/etc/rc.d/

    install -d -m 1777 output/mnt/tmp
}

install_prog() {
    root="$PWD"

    mkdir -p build && cd build
    "$root/progs/$1.sh" "$root/output/mnt"
    cd "$root"
}

build_image() {
    rm -f output/image
    fallocate -l50G output/image
    echo "n
p
1


w
" | fdisk output/image > /dev/null
    loopd=$(losetup -P -f --show output/image)
    mkfs.ext4 "$loopd"p1
    mount "$loopd"p1 /mnt
    cp -r output/mnt/* /mnt

    # Install the bootloader
    grub-install --modules=part_msdos \
                 --target=i386-pc \
                 --boot-directory="/mnt/boot" \
                 "$loopd"

    uid=$(fdisk -l output/image | grep "Disk identifier")
    uid=${uid##Disk identifier: 0x}

    cat <<EOF > /mnt/boot/grub/grub.cfg
linux /boot/bzImage quiet root=PARTUUID=$uid
boot
EOF
    umount /mnt
    losetup -d "$loopd"
}

case "$1" in
     "-i")
         shift
         for pkg in "$@"; do
             echo "==> Building $pkg"
             install_prog "$pkg"
         done
         ;;
     "-n")
         init_image
         ;;
     "-b")
         build_image
         ;;
     "-m")
         loopd=$(losetup -P -f --show output/image)
         mount "$loopd"p1 /mnt
         cd /mnt
         su
	 cd
         umount /mnt
         losetup -d "$loopd"
         ;;
esac

unset CFLAGS
unset LDFLAGS
unset MAKEFLAGS
