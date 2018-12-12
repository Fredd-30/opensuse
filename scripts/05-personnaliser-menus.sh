#!/bin/bash
#
# 05-personnaliser-menus.sh

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

ENTRIESDIR=$CWD/../config/menus
ENTRIES=$(ls $ENTRIESDIR)
MENUDIRS="/usr/share/applications"

echo

for MENUDIR in $MENUDIRS; do
	for ENTRY in $ENTRIES; do
		if [ -r $MENUDIR/$ENTRY ]; then
			echo ":: Configuration de l'entrée de menu $ENTRY."
			cat $ENTRIESDIR/$ENTRY > $MENUDIR/$ENTRY
		fi
	done
done

update-desktop-database 2> /dev/null

echo 

exit 0
