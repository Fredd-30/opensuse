#!/bin/bash
#
# 06-personnaliser-menus.sh

. source.sh

ENTRIESDIR=$CWD/../config/menus
ENTRIES=$(ls $ENTRIESDIR)
MENUDIRS="/usr/share/applications \
          /usr/share/applications/kde4"

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
