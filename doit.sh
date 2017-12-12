#!/bin/bash
ruby gethtmlfiles.rb
ruby createvinodb.rb
ruby createversionfile.rb

#Make sure you have set the password
#export SSHPASS=
#export SFTSERVER=username@sftp.domainname.com
sshpass -e sftp -oBatchMode=no -b - $SFTPSERVER << !
cd vin
put vino.db
put vino.txt
bye
!
