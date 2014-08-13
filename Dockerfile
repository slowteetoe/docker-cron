FROM phusion/baseimage:0.9.12
MAINTAINER Steven Lotito "steven.lotito@alumni.pitt.edu"

ENV HOME /root

# fix sources
RUN sed 's/main$/main universe/' -i /etc/apt/sources.list
RUN sed 's/trusty universe/trusty universe multiverse/' -i /etc/apt/sources.list
RUN sed 's/trusty-updates universe/trusty universe multiverse/' -i /etc/apt/sources.list

RUN apt-get update

RUN apt-get install -y libreadline6 libreadline6-dev wget

# install/use supervisord
RUN apt-get install -y  supervisor openssh-server
RUN mkdir -p /var/log/supervisor
ADD etc/supervisor/conf.d/supervisord.conf /etc/supervisor/conf.d/

# install cron
RUN apt-get install -y cron
ADD etc/supervisor/conf.d/cron.conf /etc/supervisor/conf.d/


# clean stuff
RUN apt-get clean && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

# let us SSH into the box
RUN mkdir -p /var/run/sshd
RUN ssh-keygen -t rsa -f /etc/ssh/ssh_host_rsa_key
RUN echo 'root:password' |chpasswd   # you'll probably want to change this asap!

EXPOSE 22

ADD crontab.txt /tmp/
RUN crontab /tmp/crontab.txt
RUN mkdir /logs

CMD ["/usr/bin/supervisord"]