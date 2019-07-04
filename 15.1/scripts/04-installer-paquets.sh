#!/bin/bash
#
# 04-installer-paquets.sh
#
# Nicolas Kovacs, 2019
#
# Ce script installe automatiquement tous les paquets listés dans le fichier
# paquets-supplementaires.txt situé dans le répertoire ../config/pkglists. 

. source.sh

# Liste des paquets supplémentaires
EXTRAS=$(egrep -v '(^\#)|(^\s+$)' \
  $CWD/../config/pkglists/paquets-supplementaires.txt)

# Installer les paquets supplémentaires
echo
for PAQUET in $EXTRAS; do
  if ! rpm -q $PAQUET 2>&1 > /dev/null ; then
    echo -e ":: Installation du paquet $PAQUET... \c"
    zypper --non-interactive install --no-recommends \
      --allow-vendor-change $PAQUET >> $LOG 2>&1
    ok
    echo "::"
  fi
done

echo

exit 0
