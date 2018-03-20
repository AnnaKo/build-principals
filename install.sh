# disable SElinux
# setenforce 0 
sed 's/SELINUX=permissive/SELINUX=disabled/' /etc/selinux/config 
#
yum -y install epel-release
#
# Turn off firewalld
systemctl disable firewalld
systemctl stop firewalld
#
yum -y install java-1.8.0-openjdk
yum -y install java-1.8.0-openjdk-devel
