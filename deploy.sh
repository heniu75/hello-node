#!/bin/bash

#####################################################################
# LOCAL
#####################################################################
pkg=hello-node
pkgtar=$pkg.tar.gz
pkgbak=$pkg.bak
machine=178.62.89.153

if [ -f $pkgtar ]; then
    echo removing $pkgtar
    rm $pkgtar
fi

# package the contents of the current folder
# https://stackoverflow.com/questions/984204/shell-command-to-tar-directory-excluding-certain-files-folders
echo packaging current folder into $pkgtar
tar --exclude='.DS_Store' --exclude='./node_modules' --exclude='./git' --exclude='.gitignore' -czvf $pkgtar *

# secure copy using the current user onto the remote server
# you must deploy using the local user which has authorised ssh keys
# on the remote server
echo securely copying $pkgtar to $machine
scp $pkgtar $machine:~/apps

#####################################################################
# REMOTE
#####################################################################

ssh $machine "

echo '***** SSH START *****'

# is this a node application?
pkgjson=~/apps/$pkg/package.json
if [ -e $pkgjson ]; then
  # assume application is installed into PM2, so first stop it
  echo stopping $pkg in PM2
  pm2 stop $pkg
fi

# clear out the old
if [ -d ~/apps/$pkgbak ]; then
    echo removing folder ~/apps/$pkgbak
    rm -rf ~/apps/$pkgbak
fi

# move current app to a backup
if [ -d ~/apps/$pkg ]; then
    echo moving folder ~/apps/$pkg to ~/apps/$pkgbak
    mv ~/apps/$pkg ~/apps/$pkgbak
fi

# create new folder
mkdir ~/apps/$pkg

# extract to the new folder
echo extracting ~/apps/$pkgtar into folder ~/apps/$pkg
tar xf ~/apps/$pkgtar -C ~/apps/$pkg

# clean up the package archive
echo removing ~/apps/$pkgtar
rm ~/apps/$pkgtar

# install system specific dependencies. Never ever copy modules
pkgjson=~/apps/$pkg/package.json
# if this is a node application
if [ -e $pkgjson ]; then
  echo installing npm dependencies
  cd ~/apps/$pkg
  npm install
  echo start the pm2 app $pkg
  pm2 start $pkg
  # DO NOT WATCH THE APP
  #pm2 start $pkg --watch
fi

echo '***** SSH END *****'

"

#####################################################################
# LOCAL AGAIN
#####################################################################

if [ -f $pkgtar ]; then
  echo removing $pkgtar
	rm $pkgtar
fi
