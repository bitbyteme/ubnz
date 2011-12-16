#! /bin/sh

# MUST BE Root
# this script CANT be run using sudo
# 

#
## need a test for user. must be root
#

fn_setup_init(){
   
   # adding apt-get restricted repositories by editing 
   # /etc/apt/sources.list file
   if ! [ -f '/etc/apt/sources.list.bak' ]; then  
      chmod 777 /etc/apt
      mv /etc/apt/sources.list /etc/apt/sources.list.bak
      cat /etc/apt/sources.list.bak | sed -e 's;^# deb http; deb http;' -e 's;^# deb-src ; deb-src ;' > /etc/apt/sources.list
      chmod 755 /etc/apt
   fi

   ########################################################

   passwd
   dpkg-query -W -f='${package}\n' > all.pkgs.gogrid
   apt-get -y update

   apt-get -y install linux-virtual
   
# phase 2
# the file all.pkgs.setup is the minimum install on vmware after some basic
# setup.
# while the file all.pkgs.gogrid is the pkgs installed at gogrid ub 10.04 
# server


   cat all.pkgs.gogrid | while read pp; do 
      grep -q "$pp" all.pkgs.setup || echo "$pp" >> extra 
   done

# assuming the new linux kernel installed is the one loaded.
# emoving all pkgs different in the ub.gogrid from vmware version.
#
# but left behing appArmor

   cat extra | while read pp; do 
      echo "$pp" | grep -q 'apparmor'  && continue
      apt-get -y purge $pp
   done 
   apt-get -y autoremove
   reboot

   apt-get -y install agit-core zsh tcl8.5
   apt-get -y upgrade

   ######################################################
   
   sudo apt-get -y update
   sudo apt-get -y upgrade
   
   sudo apt-get -y install $pkgsInstall
   sudo apt-get -y autoremove
}

fn_setup_git(){
   # clone repo  
   git clone "$gitAddress" || exit 1
   cd "$gitRepo" 
   cp -R * .* ~/. 2>/dev/null

   cd "$curDir"
   rm -rf "$gitRepo"
   git init

}

fn_setup_redis(){
   curl "$redisURL" | tar -zvx
   srcDir="redis-$redisVer"
   [ -e "$srcDir" ] || exit 2
   
   cd "$srcDir"; make
   cd "$curDir/$srcDir/src"; make test
   cd "$curDir"
}

fn_setup_python(){
   curl "$pyURL" | tar -zvx
   cd "Python-$pyVer"
   ./configure &&
   make  &&
   make altinstall || exit 3
   
   cd "$curDir"
  
   curl "http://python-distribute.org/distribute_setup.py" | /usr/local/bin/python2.7
   curl https://raw.github.com/pypa/pip/master/contrib/get-pip.py  | /usr/local/bin/python2.7


}

fn_setup_nodejs(){
   curl "$ndURL" | tar -zvx
   cd "node-v$ndVer"
   ./configure &&
   make &&
   make install || exit 4
   cd "$curlDir"

   curl 'http://npmjs.org/install.sh' | sh 
   npm 'express'

}


fn_setup_sys(){
   # setting up fn_setup_git
   (ln -s  ~/.dotfiles/bashrc ~/.bashrc
   ln -s ~/.dotfiles/zshrc ~/.zshrc
   ln -s ~/.dotfiles/aliasrc ~/.aliasrc
   ln -s ~/.dotfiles/exportrc ~/.exportrc
   ln -s ~/.dotfiles/vimrc ~/.vimrc
   ln -s ~/.dotfiles/vim ~/.vim ) 2>/dev/null

   # setting up fn_setup_redis

}

main(){
   curDir="$PWD"

   # variables for fn_setup
   pkgsBasic='build-essential curl wget git-core openssl libssl-dev'
   pkgsBasic="$pkgsBasic openssh-server openssh-client libreadline-dev"
   pkgsBasic="$pkgsBasic libsqlite3-dev libbz2-dev libssl-dev"
   pkgsExtra='vim-nox zsh tcl8.5' 
   pkgsInstall="$pkgsBasic $pkgsExtra"
   #fn_setup_init

   # variable for fn_setup_git
   gitRepo='ubnz'
   gitAddress="git://github.com/bitbyteme/$gitRepo.git"
   #fn_setup_git


   redisVer='2.4.4'
   redisURL="http://redis.googlecode.com/files/redis-$redisVer.tar.gz"
   #fn_setup_redis
   
   pyVer='2.7.2'
   pyURL="http://python.org/ftp/python/$pyVer/Python-$pyVer.tgz"
   #fn_setup_python

   ndVer='0.6.6'
   ndURL="http://nodejs.org/dist/v0.6.6/node-v$ndVer.tar.gz"
   #fn_setup_nodejs
   

   #fn_setup_sys

}

main
echo 'done'
#echo 'press enter to reboot, or ^C to quit \c'; read
#reboot



