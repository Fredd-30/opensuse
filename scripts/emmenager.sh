#!/bin/bash
#
# emmenager.sh
# 
# (c) Niki Kovacs, 2017

CWD=$(pwd)

echo 

# Bash
echo ":: Configuration de Bash pour l'administrateur."
cat $CWD/../bash/root-bashrc > /root/.bashrc

echo ":: Configuration de Bash pour les utilisateurs."
cat $CWD/../bash/user-alias > /etc/skel/.alias
for UTILISATEUR in $(ls /home); do
  cat $CWD/../bash/user-alias > /home/$UTILISATEUR/.alias
  chown $UTILISATEUR:users /home/$UTILISATEUR/.alias
done

# Xterm
echo ":: Configuration de Xterm pour l'administrateur."
cat $CWD/../xterm/Xresources > /root/.Xresources

echo ":: Configuration de Xterm pour les utilisateurs."
cat $CWD/../xterm/Xresources > /etc/skel/.Xresources
for UTILISATEUR in $(ls /home); do
  cat $CWD/../xterm/Xresources > /home/$UTILISATEUR/.Xresouces
  chown $UTILISATEUR:users /home/$UTILISATEUR/.Xresources
done

echo ":: Configuration de Vim."
cat $CWD/../vim/vimrc > /etc/vimrc

echo 

exit 0
