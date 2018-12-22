#!/bin/bash
#
# 07-installer-profil.sh
#
# Nicolas Kovacs, 2019
#
# Ce script installe une configuration personnalisée pour l'environnement de
# bureau KDE.

. source.sh

echo

# Suppression du profil existant
echo -e ":: Suppression du profil existant... \c"
sleep $DELAY
rm -rf /etc/skel/.config
mkdir /etc/skel/.config
ok

# Double clic
echo "::"
echo -e ":: Définition du double clic par défaut... \c"
sleep $DELAY
cat << EOF > /etc/skel/.config/kdeglobals
[KDE]
SingleClick=false
EOF
ok

# Taille des icônes
echo "::"
echo -e ":: Définition de la taille des icônes dans Dolphin... \c"
sleep $DELAY
cat << EOF > /etc/skel/.config/dolphinrc
[IconsMode]
IconSize=64
EOF
ok

# Fenêtres gélatineuses
echo "::"
echo -e ":: Configuration des effets du bureau... \c"
sleep $DELAY
cat << EOF > /etc/skel/.config/kwinrc
[Plugins]
wobblywindowsEnabled=true
EOF
ok

# Verrouillage de l'écran
echo "::"
echo -e ":: Configuration du verrouillage de l'écran... \c"
sleep $DELAY
cat << EOF > /etc/skel/.config/kscreenlockerrc
[Daemon]
Timeout=60
EOF
ok

# Menu par défaut
echo "::"
echo -e ":: Configuration du menu par défaut... \c"
sleep $DELAY
sed -i -e 's/org.kde.plasma.kicker/org.kde.plasma.kickoff/g' \
  /usr/share/plasma/layout-templates/org.opensuse.desktop.defaultPanel/contents/layout.js
ok

echo

exit 0
