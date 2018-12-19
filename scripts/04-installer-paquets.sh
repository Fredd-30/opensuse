#!/bin/bash
#
# 04-installer-paquets.sh

. source.sh

# Liste des paquets supplémentaires
EXTRAS=$(egrep -v '(^\#)|(^\s+$)' \
  $CWD/../config/pkglists/paquets-supplementaires.txt)

# Installer les paquets supplémentaires
echo
for PAQUET in $EXTRAS; do
  if ! rpm -q $PAQUET 2>&1 > /dev/null ; then
    echo -e ":: Installation du paquet $PAQUET... \c"
    zypper --non-interactive install --no-recommends $PAQUET >> $LOG 2>&1
    ok
    echo "::"
  fi
done

echo

exit 0
