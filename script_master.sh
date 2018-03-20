#!/bin/bash

yum install epel-release -y 
yum install java -y
mkdir -p /opt/jenkins
chown -R vagrant:vagrant /opt/jenkins/
echo "[Unit]
Description=Jenkins Service
After=network.target
[Service]
Type=simple
User=vagrant
ExecStart=/usr/bin/java -DJENKINS_HOME=/opt/jenkins/master/master -DJENKINS_DIR=/opt/jenkins/master/bin -jar /opt/jenkins/master/bin/jenkins.war
Restart=on-abort
[Install]
WantedBy=multi-user.target" > /etc/systemd/system/jenkins.service
systemctl daemon-reload
systemctl enable jenkins 
sudo yum install nginx -y
cp /vagrant/nginx.conf /etc/nginx/nginx.conf
systemctl enable nginx
systemctl start jenkins
systemctl start nginx
echo "JENKINS_HOME=/opt/jenkins/master" >> /etc/environment
echo "JENKINS_DIR=/opt/jenkins/bin" >> /etc/environment



