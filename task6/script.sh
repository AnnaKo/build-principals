#!/bin/bash

yum install epel-release -y
yum install -y unzip
yum install java -y
sudo yum install nginx -y
cp /vagrant/nginx.conf /etc/nginx/nginx.conf
systemctl enable nginx
systemctl start nginx
# installing and configuring postgresql
yum install -y postgresql-server postgresql-contrib 
postgresql-setup initdb
cp /vagrant/pg_hba.conf /var/lib/pgsql/data/
systemctl enable postgresql
systemctl start postgresql
sudo -i -u postgres psql -c "create user sonar;"
sudo -i -u postgres psql -c "alter role sonar with createdb;"
sudo -i -u postgres psql -c "alter role sonar with encrypted password 'sonar';"
sudo -i -u postgres psql -c "create database sonar owner sonar;"
sudo -i -u postgres psql -c "grant all privileges on database sonar to sonar;"
# installing and configuring sonar
wget https://sonarsource.bintray.com/Distribution/sonarqube/sonarqube-5.6.6.zip
unzip sonarqube-5.6.6.zip -d /opt
sed -i 's/#sonar.jdbc.url=jdbc:pos/sonar.jdbc.url=jdbc:pos/' /opt/sonarqube-5.6.6/conf/sonar.properties
sed -i 's/#sonar.jdbc.username=/sonar.jdbc.username=sonar/' /opt/sonarqube-5.6.6/conf/sonar.properties
sed -i 's/#sonar.jdbc.password=/sonar.jdbc.password=sonar/' /opt/sonarqube-5.6.6/conf/sonar.properties
chown -R vagrant:vagrant /opt/sonarqube-5.6.6/
echo "[Unit]
Description=Sonar 4
After=network.target network-online.target
Wants=network-online.target

[Service]
ExecStart=/opt/sonarqube-5.6.6/bin/linux-x86-64/sonar.sh start
ExecStop=/opt/sonarqube-5.6.6/bin/linux-x86-64/sonar.sh stop
ExecReload=/opt/sonarqube-5.6.6/bin/linux-x86-64/sonar.sh restart
PIDFile=/opt/sonarqube-5.6.6/bin/linux-x86-64/./SonarQube.pid
Type=forking
User=vagrant


[Install]
WantedBy=multi-user.target" > /etc/systemd/system/sonar.service
systemctl daemon-reload
systemctl start sonar
systemctl enable sonar
























