FROM ubuntu:16.04
RUN apt-get -y update
RUN apt-get -y install vim
RUN apt-get -y install ruby

#http://www.nokogiri.org/tutorials/installing_nokogiri.html
#http://stackoverflow.com/questions/28302178/how-can-i-add-a-volume-to-an-existing-docker-container
RUN apt-get -y install build-essential patch
RUN apt-get -y install ruby-dev zlib1g-dev liblzma-dev
RUN gem install nokogiri

#https://iqbalnaved.wordpress.com/2014/07/10/how-to-install-sqlite-3-8-2-on-ubuntu-14-04-and-commands-for-creating-database-and-tables/
RUN apt-get -y install sqlite3 libsqlite3-dev
RUN gem install sqlite3

RUN apt-get -y install openssh-server

COPY *.rb /root/polpriser/
COPY doit.sh /root/polpriser/
