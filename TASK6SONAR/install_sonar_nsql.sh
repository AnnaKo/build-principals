# disable SElinux
# setenforce 0 
sed 's/SELINUX=permissive/SELINUX=disabled/' /etc/selinux/config 
#
#
# Turn off firewalld
systemctl disable firewalld
systemctl stop firewalld
#
sudo yum -y install java-1.8.0-openjdk
sudo yum -y install java-1.8.0-openjdk-devel
#
yum -y install postgresql-server postgresql-contrib
postgresql-setup initdb
#
sudo sed -i 's/ident/md5/' /var/lib/pgsql/data/pg_hba.conf 
#
sudo sed -i 's/local   all             all                                     md5/local   all             all                                     ident/' /var/lib/pgsql/data/pg_hba.conf 
#
sudo sed -i 's/peer/ident/' /var/lib/pgsql/data/pg_hba.conf
#
systemctl enable postgresql
systemctl start postgresql
#
sudo su postgres -c "psql -c 'create user sonar;'"
sudo su postgres -c "psql -c 'alter role sonar with CREATEDB;'"
sudo su postgres -c "psql -c \"ALTER USER sonar WITH ENCRYPTED PASSWORD 'sonar';\""
#
sudo su postgres -c "psql -c 'create database sonar owner sonar;'"
sudo su postgres -c "psql -c 'grant all privileges on database sonar to sonar;'"
#
sudo wget https://sonarsource.bintray.com/Distribution/sonarqube/sonarqube-7.0.zip
yum -y install unzip
mkdir /opt/sonarqube-7.0/
unzip sonarqube-7.0.zip -d /opt/
#
sudo sed -i 's/^#sonar.jdbc.username=/sonar.jdbc.username=sonar/' /opt/sonarqube-7.0/conf/sonar.properties
sudo sed -i 's/^#sonar.jdbc.password=/sonar.jdbc.password=sonar/' /opt/sonarqube-7.0/conf/sonar.properties
sudo sed -i '\@^#sonar.jdbc.url=jdbc:postgresql://localhost/sonar@s@^#@@' /opt/sonarqube-7.0/conf/sonar.properties
sudo sed -i 's/^#sonar.web.port=9000/sonar.web.port=9000/' /opt/sonarqube-7.0/conf/sonar.properties
#
cd /
sudo chown vagrant:vagrant -R /opt/sonarqube-7.0/
#
/opt/sonarqube-7.0/bin/linux-x86-64/sonar.sh start
#
cd /
#
yum -y install epel-release
yum -y install nginx
#
sudo chown vagrant:vagrant /etc/nginx/*
# 
echo "
# For more information on configuration, see:
#   * Official English Documentation: http://nginx.org/en/docs/
#   * Official Russian Documentation: http://nginx.org/ru/docs/

user nginx;
worker_processes auto;
error_log /var/log/nginx/error.log;
pid /run/nginx.pid;

# Load dynamic modules. See /usr/share/nginx/README.dynamic.
include /usr/share/nginx/modules/*.conf;

events {
    worker_connections 1024;
}

http {
    log_format  main  '$remote_addr - $remote_user [$time_local] "$request" '
                      '$status $body_bytes_sent "$http_referer" '
                      '"$http_user_agent" "$http_x_forwarded_for"';

    access_log  /var/log/nginx/access.log  main;

    sendfile            on;
    tcp_nopush          on;
    tcp_nodelay         on;
    keepalive_timeout   65;
    types_hash_max_size 2048;

    include             /etc/nginx/mime.types;
    default_type        application/octet-stream;

    # Load modular configuration files from the /etc/nginx/conf.d directory.
    # See http://nginx.org/en/docs/ngx_core_module.html#include
    # for more information.
    include /etc/nginx/conf.d/*.conf;

    server {
        listen       80 default_server;
        listen       [::]:80 default_server;
        server_name  _;
        root         /usr/share/nginx/html;

        # Load configuration files for the default server block.
        include /etc/nginx/default.d/*.conf;

        location / {
            proxy_pass http://localhost:9000;
            proxy_redirect      http://localhost:9000 http://sonar;
            proxy_pass_request_headers      on;
        }

        error_page 404 /404.html;
            location = /40x.html {
        }

        error_page 500 502 503 504 /50x.html;
            location = /50x.html {
        }
    }

}
" > /etc/nginx/nginx.conf
#
sudo systemctl start nginx
sudo systemctl enable nginx
#
