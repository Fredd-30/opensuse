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

echo 

exit 0
