# Mahesh M. - Kriyate - 2009
# Contact mahesh@kriyate.in for any related queries.

#What this does is create a 200M space in RAM, making the system writable, but volatile.
#Required files are copied and then we chroot into the system.

#Create a ramdiskfs
#See Hurd pages for details regarding working of ramdiskfs. 
#Its suggested that tmpfs is better. But we have no choice as tmpfs is buggy.


settrans -c -a /mnt/ramdisk0 /hurd/storeio -T copy zero:200M
mkfs.ext2 -F -b 4096 /mnt/ramdisk0
settrans -a -o /mnt/ramdisk0 /hurd/ext2fs.static /mnt/ramdisk0
echo "RAMDISK created.\n"

echo "Copying files...\n"
 cp -r /bin /mnt/ramdisk0/
 rm -r /mnt/ramdisk0/lost+found/
 cp -r /servers/ /mnt/ramdisk0/
 cp -r /hurd/ /mnt/ramdisk0/
echo "Copying some more files...\n"
 cp -r /lib/ /mnt/ramdisk0/
 cp -r /libexec/ /mnt/ramdisk0/
echo "and more...\n"
 cp -r /sbin/ /mnt/ramdisk0/

echo "Creating directories...\n"
mkdir /mnt/ramdisk0/media/
mkdir /mnt/ramdisk0/dev/
mkdir /mnt/ramdisk0/etc/
cp setuprd.sh /mnt/ramdisk0

#This file is required if we have to install it into a partition. But it seems we cant hold such a big file in RAM.
#cp baseGNU.tgz /mnt/ramdisk0

echo "Chrooting...\n"

#Do some important things to make system running.
chroot /mnt/ramdisk0/ sh setuprd.sh

#Load a shell.
chroot /mnt/ramdisk0/ sh 


