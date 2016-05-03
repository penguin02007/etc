### Tuned
#### Apply IO scheduler with tuned profile
```
yum install tuned -y
chkconfig tuned on
chkconfig ktune on 
service ktuned start
service tuned start
cd /etc/tune-profiles
grep ELEVATOR= ktune.sysconfig
tuned-adm profile lab
cat /sys/block/sda/queue/scheduler 
```

### Profiling - systemtap
#### Edit stap scripts and allow non-root user to execute
```
yum install systemtap yum-utils kernel-devel-`uname -r` -y
debuginfo-install kernel
t=`locate stp | grep topsys`
cd /tmp
stap -v -p 4 -m topsys.ko $t
mkdir /lib/modules/`uname -r`/systemtap
gpasswd -a student stapusr
su - student
staprun /lib/modules/`uname -r`/systemtap/topsys.ko
```
### Configure EXT4 with Journal
#### 1. Create partition on journal (journal)
```
fdisk /dev/sdb
```
#### 2. Create partition on disk (data)
```
fdsik /dev/sdc
```
#### 3. Format partition as journal device
```
mkfs -t ext4 -O journal_dev -b 4096 /dev/sdb1
```
#### 4. Format partition with ext4 and external journal device
```
mkfs -t ext4 -J device=/dev/sdc1 -b 4096 /dev/sdc1
```
#### 5. Create mount point and add file system to /etc/fstab
```
"UUID=xxx"	/data ext4 data=journal 1 1
```

### Configure Modules Parameters
#### man modprobe.conf
#### options <modulename> <option>
```
lsmod
modinfo
modprobe -rv  # Unload module
modprobe -v   # Load module
``` 
### Network Tuning
#### Core networking maximum socket receive /send buffer
```
net.core.wmem_max = 12500000
net.core.rmem_max = 12500000
```
#### System memory limits for TCP / UDP
#### <min> <pressure> <max>
```
net.ipv4.tcp_wmem = 4096        16384   4194304
net.ipv4.tcp_rmem = 4096        87380   4194304
net.ipv4.udp_rmem_min = 4096
net.ipv4.udp_wmem_min = 4096
```
#### Calculate BDP for 1 GB /link with a 1s latency
```
echo 1000*1000*1000/8*1 | bc
```

#### Change BDP
```
cp /etc/sysctl  /tmp
sysctl -a |grep -i '[rw]mem' >> /tmp/sysctl
sysctl -p
```
### 
### Change system to allow 512 MB of shared memory
#### kernel.shmmax - maximum size in bytes of a single shared memory segment
```
echo 512*1024*1024/8 | bc  # 67108864
```
#### kernel.shamall - total amount of shared memory (4Kb) 
```
echo 512*1024*1024/4096 | bc 	# 131072
```
#### kernel.shmmni - system wide maximum number of shared memory segments
```
kernel.shmmni=4096
```

