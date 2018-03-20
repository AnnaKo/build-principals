#!/usr/bin/env bash

sudo yum install java-1.8.0-openjdk.x86_64 -y && echo "OpenJDK installed"
sudo echo "[Unit]
Description=Jenkins Daemon

[Service]
User=vagrant
ExecStart=/usr/bin/java -DJENKINS_HOME=/opt/jenkins/master -jar /opt/jenkins/bin/jenkins.war


[Install]
WantedBy=multi-user.target" > /etc/systemd/system/jenkins.service

sudo systemctl daemon-reload
sudo systemctl enable jenkins
sudo systemctl start jenkins && echo "jenkins started"
