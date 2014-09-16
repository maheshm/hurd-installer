#Mahesh M - Kriyate - 2009

#Contact mahesh@kriyate.in for any related queries.

##Inside chroot. Set all translators.
settrans -c /servers/socket/1 /hurd/pflocal
settrans -c /servers/socket/2 /hurd/pfinet
settrans -k /servers/exec /hurd/exec
settrans -c /servers/crash-suspend /hurd/crash --suspend
settrans -c /servers/crash-kill /hurd/crash --kill
settrans -c /servers/password /hurd/password
settrans -c /servers/default-pager /hurd/proxy-defpager

#Create devices. 
#TODO: Check the log file to find out about device info
cd /dev
MAKEDEV std
MAKEDEV hd0
MAKEDEV hd0s1

mkdir /media/cdrom

#For mounting target partition.INSTALLATION purpose
mkdir /media/target
