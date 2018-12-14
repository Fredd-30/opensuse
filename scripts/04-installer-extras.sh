#!/bin/bash
#
# 04-installer-extras.sh

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

# Installer les paquets supplémentaires
EXTRAS=$(egrep -v '(^\#)|(^\s+$)' $CWD/../config/pkglists/extras.txt)
echo
for PAQUET in $EXTRAS; do
  if ! rpm -q $PAQUET 2>&1 > /dev/null ; then
    echo -e ":: Installation du paquet $PAQUET... \c"
    zypper --non-interactive install --no-recommends $PAQUET >> $LOG 2>&1
    echo -e "[${VERT}OK${GRIS}] \c"
    sleep $DELAY
    echo
    echo "::"
  fi
done

# Installer les polices Microsoft
if [ ! -d /usr/share/fonts/truetype/microsoft ]; then
  pushd /tmp >> $LOG 2>&1
  rm -rf /usr/share/fonts/truetype/microsoft
  rm -rf /usr/share/fonts/truetype/msttcorefonts
  echo "::"
  echo -e ":: Installation des polices TrueType Microsoft... \c"
  wget -c --no-check-certificate \
    https://www.microlinux.fr/download/webcore-fonts-3.0.tar.gz >> $LOG 2>&1
  wget -c --no-check-certificate \
    https://www.microlinux.fr/download/symbol.gz >> $LOG 2>&1
  mkdir /usr/share/fonts/truetype/microsoft
  tar xvf webcore-fonts-3.0.tar.gz >> $LOG 2>&1
  pushd webcore-fonts >> $LOG 2>&1
  # La police Cambria est un fichier TTC. Si FontForge est disponible, on
  # l'utilise pour le transformer en deux fichiers TTF.
  if type fontforge > /dev/null 2>&1; then
    fontforge -lang=ff -c 'Open("vista/CAMBRIA.TTC(Cambria)"); \
      Generate("vista/CAMBRIA.TTF");Close();Open("vista/CAMBRIA.TTC(Cambria Math)"); \
      Generate("vista/CAMBRIA-MATH.TTF");Close();' >> $LOG 2>&1
    rm vista/CAMBRIA.TTC
  fi
  cp fonts/* /usr/share/fonts/truetype/microsoft/
  cp vista/* /usr/share/fonts/truetype/microsoft/
  popd >> $LOG 2>&1
  # Remplacer la police symbol.ttf par une version patchée
  # https://bugs.winehq.org/show_bug.cgi?id=24099
  gunzip -c symbol.gz > /usr/share/fonts/truetype/microsoft/symbol.ttf 
  popd >> $LOG 2>&1
  fc-cache -f -v >> $LOG 2>&1
  echo -e "[${VERT}OK${GRIS}] \c"
  sleep $DELAY
  echo
fi

# Installer les polices Apple
if [ ! -d /usr/share/fonts/apple-fonts ]; then
  cd /tmp
  rm -rf /usr/share/fonts/apple-fonts
  echo "::"
  echo -e ":: Installation des polices TrueType Apple... \c"
  wget -c --no-check-certificate \
    https://www.microlinux.fr/download/FontApple.tar.xz >> $LOG 2>&1
  mkdir /usr/share/fonts/apple-fonts
  tar xvf FontApple.tar.xz >> $LOG 2>&1
  mv Lucida*.ttf Monaco.ttf /usr/share/fonts/apple-fonts/
  fc-cache -f -v >> $LOG 2>&1
  rm -f FontApple.tar.xz
  cd - >> $LOG 2>&1
  echo -e "[${VERT}OK${GRIS}] \c"
  sleep $DELAY
  echo
fi

# Installer la police Eurostile
if [ ! -d /usr/share/fonts/eurostile ]; then
  cd /tmp
  rm -rf /usr/share/fonts/eurostile
  echo "::"
  echo -e ":: Installation de la police TrueType Eurostile... \c"
  wget -c --no-check-certificate \
    https://www.microlinux.fr/download/Eurostile.zip >> $LOG 2>&1
  unzip Eurostile.zip -d /usr/share/fonts/ >> $LOG 2>&1
  mv /usr/share/fonts/Eurostile /usr/share/fonts/eurostile
  fc-cache -f -v >> $LOG 2>&1
  rm -f Eurostile.zip
  cd - >> $LOG 2>&1
  echo -e "[${VERT}OK${GRIS}] \c"
  sleep $DELAY
  echo
fi

echo

exit 0
