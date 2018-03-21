#!/bin/bash

#install prerequisites for Sonar 
yum -y install epel-release -y
yum -y install java
yum -y install git
yum -y install nginx
yum -y install vim
yum -y install unzip
echo "Epel, Java, Nginx, Git, Vim, Unzip are installed" 

#PostgreSQL installation
yum install -y postgresql-server postgresql-contrib
postgresql-setup initdb
vim /var/lib/pgsql/data/pg_hba.conf
sed -i 's@local   all             all                                     peer@local   all             all                                     ident@g' /var/lib/pgsql/data/pg_hba.conf
sed -i 's@host    all             all             127.0.0.1/32            ident@host    all             all             127.0.0.1/32            md5@g' /var/lib/pgsql/data/pg_hba.conf
sed -i 's@host    all             all             ::1/128                 ident@host    all             all             ::1/128                 md5@g' /var/lib/pgsql/data/pg_hba.conf
systemctl enable postgresql
systemctl start postgresql
sudo -i -u postgres psql -c "create user sonar"
sudo -i -u postgres psql -c "alter role sonar with createdb"
sudo -i -u postgres psql -c "alter user sonar with encrypted password 'sonar'"
sudo -i -u postgres psql -c "CREATE USER ako PASSWORD 'ako' CREATEDB CREATEROLE CREATEUSER"
sudo -i -u postgres psql -c "create database sonar owner sonar"
sudo -i -u postgres psql -c "grant all privileges on database sonar to sonar"
systemctl restart postgresql
echo "PostgreSQL up and running"

#SonarQube installation
wget https://sonarsource.bintray.com/Distribution/sonarqube/sonarqube-5.6.6.zip
mv sonarqube-5.6.6.zip /opt
cd /opt
unzip sonarqube-5.6.6.zip
sed -i 's@#sonar.jdbc.username=@sonar.jdbc.username=sonar@g' /opt/sonarqube-5.6.6/conf/sonar.properties
sed -i 's@#sonar.jdbc.password=@sonar.jdbc.password=sonar@g' /opt/sonarqube-5.6.6/conf/sonar.properties
sed -i 's@#sonar.jdbc.url=jdbc:postgresql://localhost/sonar@sonar.jdbc.url=jdbc:postgresql://localhost/sonar@g' /opt/sonarqube-5.6.6/conf/sonar.properties
echo "Sonar installed"

#adding Sonar service
echo  "[Unit]
Description=Sonar_5_6_6
After=network.target network-online.target
Wants=network-online.target

[Service]
ExecStart=/opt/sonarqube-5.6.6/bin/linux-x86-64/sonar.sh start
ExecStop=/opt/sonarqube-5.6.6/bin/linux-x86-64/sonar.sh stop
ExecReload=/opt/sonarqube-5.6.6/bin/linux-x86-64/sonar.sh restart
PIDFile=/opt/sonarqube-5.6.6/bin/linux-x86-64/./SonarQube.pid
Type=forking
User=root

[Install]
WantedBy=multi-user.target" > /etc/systemd/system/sonar.service
systemctl daemon-reload
systemctl enable sonar.service
systemctl start sonar.service
echo "Sonar may now run as a service"

#configure nginx for sonar
systemctl enable nginx.service
sed -i 's@location / {@location / { proxy_pass http://localhost:9000; proxy_redirect http://localhost:9000 http://sonar;@g' /etc/nginx/nginx.conf
systemctl start nginx.service
echo "nginx configured for http://sonar"

#install SonarQube Scanner
cd /opt/sonarqube-5.6.6
wget https://sonarsource.bintray.com/Distribution/sonar-scanner-cli/sonar-scanner-cli-3.0.3.778-linux.zip 
unzip sonar-scanner-cli-3.0.3.778-linux.zip
rm -rf /opt/sonarqube-5.6.6/sonar-scanner-3.0.3.778-linux/conf/sonar-scanner.properties
cp /vagrant/sonar-scanner.properties /opt/sonarqube-5.6.6/sonar-scanner-3.0.3.778-linux/conf/
echo "SonarQube Scanner installed and configured"
