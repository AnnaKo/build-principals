# disable SElinux
# setenforce 0 
sed 's/SELINUX=permissive/SELINUX=disabled/' /etc/selinux/config 
#
#
# Turn off firewalld
systemctl disable firewalld
systemctl stop firewalld
#
cd /
echo "
# .bash_profile

# Get the aliases and functions
if [ -f ~/.bashrc ]; then
        . ~/.bashrc
fi

# User specific environment and startup programs

JENKINS_HOME=/opt/jenkins/master
JENKINS_DIR=/opt/jenkins/bin

PATH=$PATH:$HOME/.local/bin:$HOME/bin

export JENKINS_HOME
export JENKINS_DIR
export PATH
" > /home/vagrant/.bash_profile
#
cd /
mkdir /opt/jenkins/
mkdir /opt/jenkins/master
#
mkdir /opt/jenkins/
mkdir /opt/jenkins/bin
#
source /etc/environment
#
cd /
#
groupadd jenkins
useradd -d / -g jenkins -p $(perl -e 'print crypt("password","salt")') -m -d /home/jenkins jenkins
# 
yum -y install java-1.8.0-openjdk
yum -y install java-1.8.0-openjdk-devel
#
wget -O /etc/yum.repos.d/jenkins.repo https://pkg.jenkins.io/redhat-stable/jenkins.repo
rpm --import https://pkg.jenkins.io/redhat-stable/jenkins.io.key
yum -y install jenkins
#
#
sudo chown jenkins:jenkins /opt/jenkins/*
#
chown -R jenkins:jenkins /opt/jenkins/*
#
chown -R jenkins:jenkins /var/lib/jenkins 
chown -R jenkins:jenkins /var/cache/jenkins
chown -R jenkins:jenkins /var/log/jenkins
cd/
/etc/init.d/jenkins start
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
            proxy_pass http://localhost:8080;
            proxy_redirect      http://localhost:8080 http://jenkins;
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
