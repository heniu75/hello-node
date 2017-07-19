#!/bin/bash

#####################################################################
# LOCAL
#####################################################################
# clean out old stuff
rm hello-node.tar.gz

# archive the artefacts
tar -czvf hello-node.tar.gz *.js *.json *.cmd

# secure copy using the current user onto the remote server
# you must deploy using the local user which has authorised ssh keys
# on the remote server
scp hello-node.tar.gz 178.62.89.153:~/apps

#####################################################################
# REMOTE
#####################################################################
# stream all commands until the 'ENDSSH' marker
ssh 178.62.89.153 << 'ENDSSH'

# stop the pm2 app (PM2 must have been configured on the server)
pm2 stop hello-node

# clear out the old
rm -rf ~/apps/hello-node.bak

# move current app to a backup
mv ~/apps/hello-node ~/apps/hello-node.bak

# create new folder
mkdir ~/apps/hello-node

# extract to the new folder
tar xf ~/apps/hello-node.tar.gz -C ~/apps/hello-node

# install system specific dependencies. Never ever copy modules
npm install

# start the pm2 app
pm2 start hello-node

# clean up the archive
rm ~/apps/hello-node.tar.gz

# send signal that ssh session is to close
ENDSSH