#!/bin/bash
ruby /polpriser/gethtmlfiles.rb
ruby /polpriser/createvinodb.rb
ruby /polpriser/createversionfile.rb

#Make sure you have set the password
#export SSHPASS=Kite4All
#export SFTSERVER=erlendthune@sftp.domainname.com
#sshpass -e sftp -oBatchMode=no -b - $SFTPSERVER << !
#cd vin
#put vino.db
#put vino.txt
#bye
#!
