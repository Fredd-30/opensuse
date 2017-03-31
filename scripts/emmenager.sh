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

# Xterm
echo ":: Configuration de Xterm pour l'administrateur."
cat $CWD/../xterm/Xresources > /root/.Xresources

echo ":: Configuration de Xterm pour les utilisateurs."
for UTILISATEUR in $(ls /home); do
  cat $CWD/../xterm/Xresources > /home/$UTILISATEUR/.Xresouces
  chown $UTILISATEUR:users /home/$UTILISATEUR/.Xresources
done

echo 

exit 0
