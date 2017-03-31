#!/bin/bash
#
# setup.sh
# 
# (c) Niki Kovacs, 2017

CWD=$(pwd)
MIRROR="http://download.opensuse.org"
PACKMAN="http://ftp.gwdg.de/pub/linux/misc/packman/suse/openSUSE_Leap_42.2"

echo 

# Bash
echo "Configuring Bash for root."
cat $CWD/../bash/root-bashrc > /root/.bashrc
echo

echo "Configuring Bash for users."
cat $CWD/../bash/user-alias > /etc/skel/.alias
for UTILISATEUR in $(ls /home); do
  cat $CWD/../bash/user-alias > /home/$UTILISATEUR/.alias
  chown $UTILISATEUR:users /home/$UTILISATEUR/.alias
done
echo

# Xterm
echo "Configuring Xterm for root."
cat $CWD/../xterm/Xresources > /root/.Xresources
echo

echo "Configuring Xterm for users"
cat $CWD/../xterm/Xresources > /etc/skel/.Xresources
for UTILISATEUR in $(ls /home); do
  cat $CWD/../xterm/Xresources > /home/$UTILISATEUR/.Xresouces
  chown $UTILISATEUR:users /home/$UTILISATEUR/.Xresources
done
echo

echo "Configuring Vim."
cat $CWD/../vim/vimrc > /etc/vimrc
echo

echo "Removing preconfigured package repositories."
rm -f /etc/zypp/repos.d/*.repo
echo 

#echo ":: Adding OSSAjout du dépôt de paquets OSS."
zypper addrepo $MIRROR/distribution/leap/42.2/repo/oss oss 

#echo ":: Ajout du dépôt de paquets NON-OSS."
zypper addrepo $MIRROR/distribution/leap/42.2/repo/non-oss non-oss

#echo ":: Ajout du dépôt de mises à jour OSS."
zypper addrepo $MIRROR/update/leap/42.2/oss oss-updates

#echo ":: Ajout du dépôt de mises à jour NON-OSS."
zypper addrepo $MIRROR/update/leap/42.2/non-oss non-oss-updates

#echo ":: Ajout du dépôt tiers Packman."
zypper addrepo --priority 1 $PACKMAN packman 

zypper refresh 

echo 

exit 0
