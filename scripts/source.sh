# source.sh
#
# Opérations communes à tous les scripts de ce répertoire

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

# Version
VERSION=15.1

# Miroirs de téléchargement
MIRROR="http://download.opensuse.org"
NVIDIA="https://download.nvidia.com"
PACKMAN="http://ftp.gwdg.de/pub/linux/misc/packman/suse/openSUSE_Leap_${VERSION}/"
KDEXTRA="https://download.opensuse.org/repositories/KDE:/Extra/openSUSE_Leap_${VERSION}/"
DVDCSS="http://opensuse-guide.org/repo/openSUSE_Leap_${VERSION}/"
RECODE="https://download.opensuse.org/repositories/home:/manfred-h/openSUSE_Leap_${VERSION}/"

# Couleurs
VERT="\033[01;32m"
GRIS="\033[00m"

# Pause entre les opérations
DELAY=1

# Afficher [OK] en cas de succès
function ok () {
  echo -e "[${VERT}OK${GRIS}] \c"
  sleep $DELAY
  echo
}

# Journal
LOG=/tmp/$(basename "$0" .sh).log

# Nettoyer le fichier journal
echo > $LOG

