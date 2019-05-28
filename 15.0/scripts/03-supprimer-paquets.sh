#!/bin/bash
#
# 03-supprimer-paquets.sh
#
# Nicolas Kovacs, 2019
#
# Ce script supprime tous les paquets listés dans le fichier
# paquets-inutiles.txt situé dans le répertoire ../config/pkglists. Il se
# charge également de nettoyer les dépendances orphelines.

. source.sh

# Liste des paquets inutiles
CHOLESTEROL=$(egrep -v '(^\#)|(^\s+$)' \
  $CWD/../config/pkglists/paquets-inutiles.txt)

# Supprimer les paquets inutiles 
echo
for PAQUET in $CHOLESTEROL; do
  if rpm -q $PAQUET 2>&1 > /dev/null ; then
    echo -e ":: Suppression du paquet $PAQUET... \c"
    zypper --non-interactive remove --clean-deps $PAQUET >> $LOG 2>&1
    ok
    echo "::"
  fi
done

echo

exit 0
