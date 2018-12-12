#!/bin/bash
#
# 04-installer-extras.sh

# Exécuter en tant que root
if [ $EUID -ne 0 ] ; then
  echo "::"
  echo ":: Vous devez être root pour exécuter ce script."
  echo "::"
  exit 1
fi

# Répertoire courant
CWD=$(pwd)

# Interrompre en cas d'erreur
set -e

# Couleurs
VERT="\033[01;32m"
GRIS="\033[00m"

# Journal
LOG=/tmp/$(basename "$0" .sh).log

# Pause entre les opérations
DELAY=1

# Nettoyer le fichier journal
echo > $LOG

# Installer les paquets supplémentaires
EXTRAS=$(egrep -v '(^\#)|(^\s+$)' $CWD/../config/pkglists/extras.txt)
echo
for PAQUET in $EXTRAS; do
  if ! rpm -q $PAQUET 2>&1 > /dev/null ; then
    echo -e ":: Installation du paquet $PAQUET... \c"
    zypper --non-interactive install --no-recommends $PAQUET >> $LOG 2>&1
    echo -e "[${VERT}OK${GRIS}] \c"
    sleep $DELAY
    echo
    echo "::"
  fi
done

echo

exit 0
