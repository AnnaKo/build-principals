#!/bin/bash

#install prerequisites for Jenkins 
yum -y install epel-release -y
yum -y install java-1.8.0-openjdk.x86_64
yum -y install git
yum -y install nginx
echo "Java and Git installed" 

#create jenkins user
useradd jenkins
echo "jenkins user added"

#download Jenkins
mkdir -p /opt/jenkins/master
mkdir -p /opt/jenkins/bin
chown -R jenkins:jenkins /opt/jenkins
cd /opt/jenkins/bin
wget -v http://mirrors.jenkins.io/war-stable/latest/jenkins.war
# java -jar jenkins.war
echo "Jenkins installed to /opt/jenkins/bin"

#create init file for jenkins
echo  "[Unit]
Description=Jenkins Service
After=network.target

[Service]
Type=simple
User=jenkins
ExecStart=/usr/bin/java -DJENKINS_HOME=/opt/jenkins/master -DJENKINS_DIR=/opt/jenkins/bin -jar /opt/jenkins/bin/jenkins.war
Restart=on-abort

[Install]
WantedBy=multi-user.target" > /etc/systemd/system/jenkins.service
systemctl daemon-reload
systemctl enable jenkins.service
systemctl start jenkins.service
echo "jenkins is a service now"

#settings up system variables
export JENKINS_HOME="/opt/jenkins/master"
export JENKINS_DIR="/opt/jenkins/bin"

#configure nginx for jenkins
systemctl enable nginx.service
systemctl start nginx.service
rm -rf /etc/nginx/nginx.conf
cp /vagrant/jtest-nginx/nginx.conf /etc/nginx/nginx.conf
systemctl restart nginx.service
echo "nginx configured for http://jenkins11"





