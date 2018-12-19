#!/bin/bash
#
# 03-supprimer-paquets.sh

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
