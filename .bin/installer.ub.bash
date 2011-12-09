#! /bin/sh

fn_setup_init(){
   sudo echo ''
   # adding apt-get restricted repositories by editing 
   # /etc/apt/sources.list file
   if ! [ -f '/etc/apt/sources.list.bak' ]; then  
      sudo chmod 777 /etc/apt
      sudo mv /etc/apt/sources.list /etc/apt/sources.list.bak
      sudo cat /etc/apt/sources.list.bak | sed -e 's;^# deb http; deb http;' -e 's;^# deb-src ; deb-src ;' > /etc/apt/sources.list
      sudo chmod 755 /etc/apt
   fi
   
   sudo apt-get -y update
   sudo apt-get -y upgrade
   
   sudo apt-get -y install $pkgsInstall
   sudo apt-get -y autoremove
}

fn_setup_git(){
   # clone repo  
   git clone "$gitAddress" || exit 4
   cd "$gitRepo" 
   cp -R * .* ~/. 2>/dev/null

   cd "$curDir"
   rm -rf "$gitRepo"
   git init

}

fn_setup_redis(){
   curl "$redisURL" | tar -zvx
   srcDir="redis-$redisVer"
   [ -e "$srcDir" ] || exit 1
   
   cd "$srcDir"; make
   cd "$curDir/$srcDir/src"; make test
}

fn_setup_python(){
   #curl "$pyURL" | tar -zvx
   
   :

}



fn_setup_sys(){
   # setting up fn_setup_git
   cat  ~/.dotfiles/bashrc >> ~/.bashrc
   cat ~/.dotfiles/zshrc >> ~/.zshrc
   
   ln -s ~/.dotfiles/aliasrc ~/.aliasrc
   ln -s ~/.dotfiles/exportrc ~/.exportrc
   ln -s ~/.dotfiles/vimrc ~/.vimrc
   ln -s ~/.dotfiles/vim ~/.vim

   # setting up fn_setup_redis

}

main(){
   curDir="$PWD"

   # variables for fn_setup
   pkgsBasic='build-essential curl wget git-core openssl libssl-dev'
   pkgsBasic="$pkgsBasic openssh-server openssh-client"
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
   fn_setup_python


   #fn_setup_sys

}

main
echo 'done'
#echo 'press enter to reboot, or ^C to quit \c'; read
#reboot




