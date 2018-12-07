#!/bin/bash
#
# postinstall.sh
#
# Script post-installation pour OpenSUSE Leap 15.0
#
# (c) Nicolas Kovacs, 2018

# Exécuter en tant que root
if [ $EUID -ne 0 ] ; then
  echo "::"
  echo ":: Vous devez être root pour exécuter ce script."
  echo "::"
  exit 1
fi

# Répertoire courant
CWD=$(pwd)

# Version
VERSION=15.0

# Miroirs de téléchargement
MIRROR="http://download.opensuse.org"
PACKMAN="http://ftp.gwdg.de/pub/linux/misc/packman/suse/openSUSE_Leap_${VERSION}/"

# Interrompre en cas d'erreur
set -e

# Couleurs
VERT="\033[01;32m"
GRIS="\033[00m"

# Journal
LOG=/tmp/postinstall.log

# Pause entre les opérations
DELAY=1

# Nettoyer le fichier journal
echo > $LOG

# Bannière
sleep $DELAY
echo
echo "     ############################################" | tee -a $LOG
echo "     ### OpenSUSE Leap 15.0 Post-installation ###" | tee -a $LOG
echo "     ############################################" | tee -a $LOG
echo | tee -a $LOG
sleep $DELAY
echo "     Pour suivre l'avancement des opérations, ouvrez une"
echo "     deuxième console et invoquez la commande suivante :"
echo
echo "       # tail -f /tmp/postinstall.log"
echo
sleep $DELAY

# Personnalisation du shell Bash pour root
echo "::"
echo -e ":: Configuration du shell Bash pour l'administrateur... \c"
sleep $DELAY
cat $CWD/config/bash/root-bashrc > /root/.bashrc
echo -e "[${VERT}OK${GRIS}] \c"
sleep $DELAY
echo

# Personnalisation du shell Bash pour les utilisateurs
echo "::"
echo -e ":: Configuration du shell Bash pour les utilisateurs... \c"
sleep $DELAY
cat $CWD/config/bash/user-alias > /etc/skel/.alias
for UTILISATEUR in $(ls /home); do
  cat $CWD/config/bash/user-alias > /home/$UTILISATEUR/.alias
  chown $UTILISATEUR:users /home/$UTILISATEUR/.alias
done
echo -e "[${VERT}OK${GRIS}] \c"
sleep $DELAY
echo

# Quelques options pratiques pour Vim
echo "::"
echo -e ":: Configuration de Vim... \c"
sleep $DELAY
cat $CWD/config/vim/vimrc > /etc/vimrc
echo -e "[${VERT}OK${GRIS}] \c"
sleep $DELAY
echo

# Pour l'instant on n'utilise que l'IPv4
if ! grep ipv6.disable=1 /etc/default/grub > /dev/null ; then
  echo "::"
  echo -e ":: Désactivation de l'IPv6... \c"
  sleep $DELAY
  sed -i -e 's/quiet showopts/quiet ipv6.disable=1 showopts/g' /etc/default/grub
  grub2-mkconfig -o /boot/grub2/grub.cfg >> $LOG 2>&1
  echo -e "[${VERT}OK${GRIS}] \c"
  sleep $DELAY
  echo
fi

# Configurer les dépôts de paquets
echo "::"
echo -e ":: Configuration des dépôts de paquets... \c"
sleep $DELAY
rm -f /etc/zypp/repos.d/*.repo
zypper addrepo $MIRROR/distribution/leap/$VERSION/repo/oss oss >> $LOG 2>&1
zypper addrepo $MIRROR/distribution/leap/$VERSION/repo/non-oss non-oss >> $LOG 2>&1
zypper addrepo $MIRROR/update/leap/$VERSION/oss oss-updates >> $LOG 2>&1
zypper addrepo $MIRROR/update/leap/$VERSION/non-oss non-oss-updates >> $LOG 2>&1
zypper addrepo --priority 90 $PACKMAN packman >> $LOG 2>&1
echo -e "[${VERT}OK${GRIS}] \c"
sleep $DELAY
echo

# Mise à jour initiale
echo "::"
echo -e ":: Mise à jour initiale du système... \c"
zypper --gpg-auto-import-keys refresh >> $LOG 2>&1
zypper update >> $LOG 2>&1
echo -e "[${VERT}OK${GRIS}] \c"
sleep $DELAY
echo

# Installer le serveur graphique X11
echo "::"
echo -e ":: Installation du serveur graphique X11... \c"
zypper --non-interactive install --no-recommends -t pattern x11 >> $LOG 2>&1
zypper --non-interactive install xdm WindowMaker xorg-x11-fonts >> $LOG 2>&1
echo -e "[${VERT}OK${GRIS}] \c"
sleep $DELAY
echo

# Configuration du terminal graphique
echo "::"
echo -e ":: Configuration du terminal graphique... \c"
sleep $DELAY
cat $CWD/config/xterm/Xresources > /root/.Xresources
cat $CWD/config/xterm/Xresources > /etc/skel/.Xresources
for UTILISATEUR in $(ls /home); do
  cat $CWD/config/xterm/Xresources > /home/$UTILISATEUR/.Xresources
  chown $UTILISATEUR:users /home/$UTILISATEUR/.Xresources
done
echo -e "[${VERT}OK${GRIS}] \c"
sleep $DELAY
echo

echo

exit 0

