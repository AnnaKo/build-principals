#!/bin/bash

#install prerequisites for Nexus 
yum -y install epel-release java-1.8.0-openjdk.x86_64 git nginx vim unzip
echo "Epel, Java, Git, Nginx are installed" 

#install Nexus itself
mkdir /opt/nexus
wget -v https://download.sonatype.com/nexus/3/latest-unix.tar.gz
tar -xvzf latest-unix.tar.gz -C /opt/nexus
echo "Nexus installed"

#adding Nexus user with rights to Nexus only
useradd nexus
chown -R nexus:nexus /opt/nexus/nexus-3.9.0-01/
chown -R nexus:nexus /opt/nexus/sonatype-work/
echo "Nexus user with rights to Nexus only is added"

#create init file for nexus
echo  "[Unit]
Description=nexus service
After=network.target

[Service]
Type=forking
ExecStart=/opt/nexus/nexus-3.9.0-01/bin/nexus start
ExecStop=/opt/nexus/nexus-3.9.0-01/bin/nexus stop
User=nexus
Restart=on-abort

[Install]
WantedBy=multi-user.target" > /etc/systemd/system/nexus.service
systemctl daemon-reload
systemctl enable nexus.service
systemctl start nexus.service
echo "Nexus is a service now"

#configure nginx for nexus
systemctl enable nginx.service
systemctl start nginx.service
rm -rf /etc/nginx/nginx.conf
cp /vagrant/nexus-nginx/nginx.conf /etc/nginx/nginx.conf
systemctl restart nginx.service
echo "nginx configured for http://nexus (also available at http://192.168.56.150:8081)"

#adding nexus to hosts file
sed -i '$ a 192.168.56.150 nexus' /etc/hosts
echo "Nexus URL added to this VM hosts file"

