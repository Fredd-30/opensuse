#!/bin/bash
#
# 04-elaguer-bureau.sh

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

# Supprimer les groupes de paquets
PATTERNS=$(egrep -v '(^\#)|(^\s+$)' $CWD/../config/pkglists/groupes.txt)
echo
for PATTERN in $PATTERNS; do
  if rpm -q $PATTERN 2>&1 > /dev/null ; then
    echo -e ":: Suppression du groupe de paquets $PATTERN... \c"
    zypper --non-interactive remove $PATTERN >> $LOG 2>&1
    echo -e "[${VERT}OK${GRIS}] \c"
    sleep $DELAY
    echo
    echo "::"
  fi
done

# Supprimer les paquets inutiles 
CHOLESTEROL=$(egrep -v '(^\#)|(^\s+$)' $CWD/../config/pkglists/cholesterol.txt)
echo
for PAQUET in $CHOLESTEROL; do
  if rpm -q $PAQUET 2>&1 > /dev/null ; then
    echo -e ":: Suppression du paquet $PAQUET... \c"
    zypper --non-interactive remove --clean-deps $PAQUET >> $LOG 2>&1
    echo -e "[${VERT}OK${GRIS}] \c"
    sleep $DELAY
    echo
    echo "::"
  fi
done

echo

exit 0
