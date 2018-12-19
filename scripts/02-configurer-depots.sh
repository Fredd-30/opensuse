#!/bin/bash
#
# 02-configurer-depots.sh

# Exécuter en tant que root
if [ $EUID -ne 0 ] ; then
  echo "::"
  echo ":: Vous devez être root pour exécuter ce script."
  echo "::"
  exit 1
fi

# Version
VERSION=15.0

# Miroirs de téléchargement
MIRROR="http://download.opensuse.org"
NVIDIA="https://download.nvidia.com"
PACKMAN="http://ftp.gwdg.de/pub/linux/misc/packman/suse/openSUSE_Leap_${VERSION}/"
DVDCSS="http://opensuse-guide.org/repo/openSUSE_Leap_${VERSION}/"

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

# Configurer les dépôts de paquets
echo
echo -e ":: Suppression des dépôts existants... \c"
sleep $DELAY
rm -f /etc/zypp/repos.d/*.repo
echo -e "[${VERT}OK${GRIS}] \c"
sleep $DELAY
echo
echo "::"
echo -e ":: Configuration du dépôt [oss]... \c"
zypper addrepo $MIRROR/distribution/leap/$VERSION/repo/oss oss >> $LOG 2>&1
echo -e "[${VERT}OK${GRIS}] \c"
sleep $DELAY
echo
echo "::"
echo -e ":: Configuration du dépôt [non-oss]... \c"
zypper addrepo $MIRROR/distribution/leap/$VERSION/repo/non-oss non-oss >> $LOG 2>&1
echo -e "[${VERT}OK${GRIS}] \c"
sleep $DELAY
echo
echo "::"
echo -e ":: Configuration du dépôt [oss-updates]... \c"
zypper addrepo $MIRROR/update/leap/$VERSION/oss oss-updates >> $LOG 2>&1
echo -e "[${VERT}OK${GRIS}] \c"
sleep $DELAY
echo
echo "::"
echo -e ":: Configuration du dépôt [non-oss-updates]... \c"
zypper addrepo $MIRROR/update/leap/$VERSION/non-oss non-oss-updates >> $LOG 2>&1
echo -e "[${VERT}OK${GRIS}] \c"
sleep $DELAY
echo
echo "::"
echo -e ":: Configuration du dépôt [nvidia]... \c"
zypper addrepo $NVIDIA/opensuse/leap/$VERSION nvidia >> $LOG 2>&1
echo -e "[${VERT}OK${GRIS}] \c"
sleep $DELAY
echo
echo "::"
echo -e ":: Configuration du dépôt [packman]... \c"
zypper addrepo --priority 90 $PACKMAN packman >> $LOG 2>&1
echo -e "[${VERT}OK${GRIS}] \c"
sleep $DELAY
echo
echo "::"
echo -e ":: Configuration du dépôt [dvdcss]... \c"
zypper addrepo $DVDCSS dvdcss >> $LOG 2>&1
echo -e "[${VERT}OK${GRIS}] \c"
sleep $DELAY
echo
echo "::"
echo -e ":: Synchronisation et import des clés GPG... \c"
zypper --gpg-auto-import-keys refresh >> $LOG 2>&1
echo -e "[${VERT}OK${GRIS}] \c"
sleep $DELAY
echo
echo "::"
echo -e ":: Mise à jour des paquets... \c"
zypper --non-interactive update --allow-vendor-change >> $LOG 2>&1
echo -e "[${VERT}OK${GRIS}] \c"
sleep $DELAY
echo

echo

exit 0

