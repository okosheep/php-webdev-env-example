FROM centos:centos7.4.1708
MAINTAINER Hiroomi Okoshi <hiroomi@okoshi.net>

ADD supervisord.conf /etc/supervisord.conf
ADD index.html /var/www/html/
ADD index.php /var/www/html/
ADD sf.conf /etc/httpd/conf.d/

# yum
RUN yum update -y
RUN yum -y install epel-release
RUN yum -y install http://dev.mysql.com/get/mysql-community-release-el7-5.noarch.rpm
RUN yum -y install openssh-server httpd php php-cli php-common composer npm git wget curl python-pip mysql mysql-devel mysql-utilities

# npm
RUN npm install -g grunt-cli

# root ユーザでログイン可能に変更
RUN sed -ri 's/^#PermitRootLogin yes/PermitRootLogin yes/' /etc/ssh/sshd_config

# root ユーザのパスワードを root にする
RUN echo 'root:root' | chpasswd

# 公開鍵の登録がなければログインできないため登録。
RUN ssh-keygen -t rsa -N "" -f /etc/ssh/ssh_host_rsa_key

# pip
RUN pip install --upgrade pip
RUN pip install supervisor

# sshd: 22, httpd: 80 を公開する
EXPOSE 22 80

# Supervisor を起動する
CMD ["/usr/bin/supervisord"]

