#http://www.nokogiri.org/tutorials/installing_nokogiri.html
#http://stackoverflow.com/questions/28302178/how-can-i-add-a-volume-to-an-existing-docker-container
#https://iqbalnaved.wordpress.com/2014/07/10/how-to-install-sqlite-3-8-2-on-ubuntu-14-04-and-commands-for-creating-database-and-tables/

FROM ubuntu:22.04

RUN apt-get update && \
    apt-get -y install vim && \
    apt-get -y install ruby && \
    apt-get -y install build-essential patch && \
    apt-get -y install ruby-dev zlib1g-dev liblzma-dev && \
    apt-get -y install sqlite3 libsqlite3-dev pkg-config && \
    apt-get -y install openssh-server && \
    apt-get -y update && \
    apt-get -y install git && \
    apt-get -y install sshpass && \
    gem install nokogiri && \
    gem install sqlite3 && \
    gem install mechanize

#CMD cd && git clone https://github.com/erlendthune/polpriser.git && cd polpriser && ./doit.sh
CMD cd && cd polpriser && ./doit.sh