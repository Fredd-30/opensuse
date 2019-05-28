#!/bin/bash
#
# 06-personnaliser-menus.sh
#
# Nicolas Kovacs, 2019
#
# Ce script personnalise les entrées de menu KDE des applications en remplaçant
# les fichiers *.desktop situés dans l'arborescence /usr/share/applications par
# des versions modifiées. Les traductions sont fournies en français, en anglais
# et en allemand. Dans le cas où une mise à jour écrase une entrée de menu
# personnalisée, il suffit de réexécuter le script pour la restaurer.

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
