### Tuned ###
#### Change IO scheduler with tuned profile
```
yum install tuned -y
chkconfig tuned on
chkconfig ktune on 
service ktuned start
service tuned start
cd /etc/tune-profiles
grep ELEVATOR= ktune.sysconfig
tuned-adm profile rh442
cat /sys/block/sda/queue/scheduler 


### Profiling - systemtap ###
### Edit stap scripts and allow non-root user to execute
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
