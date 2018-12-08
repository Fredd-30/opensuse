#!/bin/bash
#
# 02-desactiver-ipv6.sh

# Exécuter en tant que root
if [ $EUID -ne 0 ] ; then
  echo "::"
  echo ":: Vous devez être root pour exécuter ce script."
  echo "::"
  exit 1
fi

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

# Désactiver l'IPv6
if ! grep ipv6.disable=1 /etc/default/grub > /dev/null ; then
  echo
  echo -e ":: Désactivation de l'IPv6... \c"
  sleep $DELAY
  sed -i -e 's/quiet showopts/quiet ipv6.disable=1 showopts/g' /etc/default/grub
  grub2-mkconfig -o /boot/grub2/grub.cfg >> $LOG 2>&1
  echo -e "[${VERT}OK${GRIS}] \c"
  sleep $DELAY
  echo
fi

echo

exit 0

