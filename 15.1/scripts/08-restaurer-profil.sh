#!/bin/bash
#
# 08-restaurer-profil.sh
#
# Nicolas Kovacs, 2019
#
# Ce script installe une configuration personnalisée du bureau KDE pour tous
# les utilisateurs du système.

echo

if [ ! -d /etc/skel/.config ]; then
  echo ":: Les profils par défaut ne sont pas installés."
  echo
  exit 1
fi


if [[ $(hostnamectl | grep "Operating System") =~ CentOS ]]; then
  SYSTEM="CentOS"
  echo ":: Distribution Linux : $SYSTEM"
elif [[ $(hostnamectl | grep "Operating System") =~ openSUSE ]]; then
  SYSTEM="openSUSE"
  echo ":: Distribution Linux : $SYSTEM"
else
  echo ":: Distribution Linux non supportée."
  exit 1
fi

echo

for UTILISATEUR in $(ls /home); do
  echo ":: Mise à jour du profil de l'utilisateur $UTILISATEUR."
  rm -rf /home/$UTILISATEUR/.config
  cp -R /etc/skel/.config /home/$UTILISATEUR/
  if [ "$SYSTEM" == "CentOS" ]; then 
    chown -R $UTILISATEUR:$UTILISATEUR /home/$UTILISATEUR/.config
  else
    chown -R $UTILISATEUR:users /home/$UTILISATEUR/.config
  fi
done

echo
exit 0
