#! /bin/sh

# MUST BE Root
# this script CANT be run using sudo
# 

#
## need a test for user. must be root
#

err=99
[ "$USER" = 'root' ] || exit $err

fn_setup_gogrid(){
   # phase 2 of gogrid setup.
   #
   # the file all.pkgs.min is the minimum install on vmware after some 
   # basic setup.
   # while the file all.pkgs.gogrid is the pkgs installed at gogrid 
   # ub 10.04 server
   
   err=1
   apt-get -y update &&
   apt-get -y install curl &&
   curl 'https://raw.github.com/bitbyteme/ubnz/master/.bin/all.pkgs.min' > "$tmp/all.pkgs.min" || exit $err

   err=2
   rm "$tmp/extra" 2>/dev/null 
   dpkg-query -W -f='${package}\n' > "$tmp/all.pkgs.gogrid"  &&
   cat "$tmp/all.pkgs.gogrid" | while read pp; do 
      grep -q "$pp" "$tmp/all.pkgs.min" || echo "$pp" >> "$tmp/extra" 
   done || exit $err

   # removing all pkgs different in the ub.gogrid from vmware 
   # ub.min version.
   #
   # but left behing appArmor, install-info
   err=3
   skip="apparmor|install-info|irqbalance|psmisc|linux-"
   #skip="$skip|uuid-runtime|wireless-crda"

   echo "\n++++++++++++ BEGIN +++++++++++\n"
   
   cat "$tmp/extra" | while read pp; do 
      echo "$pp" | grep -qE "$skip"  && continue
      apt-get -y purge "$pp" || exit $err
   done 

   echo "\n++++++++++++ DONE ++++++++++++\n"

   err=4
   apt-get -y autoremove &&
   apt-get -y update || exit $err
  # reboot || exit $err
}

fn_setup_init(){
   echo 'export phase=03' >> ~/.bashrc

   pkgsBasic='build-essential curl wget git-core openssl libssl-dev'
   pkgsBasic="$pkgsBasic openssh-server openssh-client libreadline-dev"
   pkgsBasic="$pkgsBasic libsqlite3-dev libbz2-dev libssl-dev tcl8.5"
   pkgsExtra='vim-nox zsh'

   pkgsInstall="$pkgsBasic $pkgsExtra"
   
   # adding apt-get restricted repositories by editing 
   # /etc/apt/sources.list file
   if ! [ -f '/etc/apt/sources.list.bak' ]; then  

      err=5
      chmod 777 /etc/apt &&
      mv /etc/apt/sources.list /etc/apt/sources.list.bak &&
      cat /etc/apt/sources.list.bak | sed -e 's;^# deb http; deb http;' -e 's;^# deb-src ; deb-src ;' > /etc/apt/sources.list &&
      chmod 755 /etc/apt || exit $err
   fi
   
   sudo apt-get -y update &&
   sudo apt-get -y upgrade &&
   sudo apt-get -y install $pkgsInstall &&
   sudo apt-get -y autoremove &&
   reboot || exit $err
}

fn_setup_git(){
   # clone repo  
   gitRepo='ubnz'
   gitAddress="git://github.com/bitbyteme/$gitRepo.git"
   
   err=6
   git clone "$gitAddress" || exit $err
   [ "$curDir" = "$HOME" ] || {
      mv "$gitRepo" "$HOME/." || exit $err
   }
}

fn_setup_redis(){
   redisVer='2.4.6'
   redisURL="http://redis.googlecode.com/files/redis-$redisVer.tar.gz"
   
   err=7
   srcDir="redis-$redisVer"
   curl "$redisURL" | tar -zvx &&
   cd "$srcDir" && make &&
   cd "$curDir/$srcDir/src" && make test &&
   cd "$curDir" || exit $err
}

fn_setup_python(){
   pyVer='2.7.2'
   pyURL="http://python.org/ftp/python/$pyVer/Python-$pyVer.tgz"
   
   err=9
   curl "$pyURL" | tar -zvx &&
   cd "Python-$pyVer" && 
   ./configure && make  &&
   make altinstall &&
   
   cd "$curDir" &&
  
   curl "http://python-distribute.org/distribute_setup.py" | /usr/local/bin/python2.7 &&
   curl "https://raw.github.com/pypa/pip/master/contrib/get-pip.py"  | /usr/local/bin/python2.7 || exit $err
}

fn_setup_nodejs(){
   ndVer='0.6.8'
   ndURL="http://nodejs.org/dist/v0.6.6/node-v$ndVer.tar.gz"

   err=10
   curl "$ndURL" | tar -zvx &&
   cd "node-v$ndVer" &&
   ./configure &&
   make &&
   make install &&

   cd "$curlDir" &&

   curl 'http://npmjs.org/install.sh' | sh &&
   npm 'express' || exit $err
}

fn_setup_sys(){
   
   #
   # setup startup scripts, bashrc, passwd, host
   #
   
   err=11
   mkdir ~/.backups &&
   mv "$HOME/$gitRepo/.dotfiles" "$HOME/." &&
   mv ~/.bashrc  ~/.vimrc ~/.vim ~/.zshrc ~/.backups/. || exit $err
   
   (ln -s  ~/.dotfiles/bashrc ~/.bashrc
   ln -s ~/.dotfiles/zshrc ~/.zshrc
   ln -s ~/.dotfiles/aliasrc ~/.aliasrc
   ln -s ~/.dotfiles/exportrc ~/.exportrc
   ln -s ~/.dotfiles/vimrc ~/.vimrc
   ln -s ~/.dotfiles/vim ~/.vim ) 2>/dev/null
}

main(){
   curDir="$PWD"
   tmp="$HOME/.tmp/"

   err=98
   mkdir -p "$tmp" || exit $err

   [ -z "$phase" ] && fn_setup_gogrid
   #[ "$phase" = '01' ] && fn_setup_gogrid02
   [ "$phase" = '01' ] && fn_setup_init
   [ "$phase" = '02' ] && {
      fn_setup_git
      fn_setup_redis
      fn_setup_python
      fn_setup_nodejs
      fn_setup_sys
   }
}

main
echo 'done'
#echo 'press enter to reboot, or ^C to quit \c'; read
#reboot



