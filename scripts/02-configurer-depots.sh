#!/bin/bash
#
# 02-configurer-depots.sh

. source.sh

# Suppression des dépôts existants
echo
echo -e ":: Suppression des dépôts existants... \c"
sleep $DELAY
rm -f /etc/zypp/repos.d/*.repo
ok

# Configuration du dépôt [oss]
echo "::"
echo -e ":: Configuration du dépôt [oss]... \c"
zypper addrepo $MIRROR/distribution/leap/$VERSION/repo/oss oss >> $LOG 2>&1
ok

# Configuration du dépôt [non-oss]
echo "::"
echo -e ":: Configuration du dépôt [non-oss]... \c"
zypper addrepo $MIRROR/distribution/leap/$VERSION/repo/non-oss non-oss >> $LOG 2>&1
ok

# Configuration du dépôt [oss-updates]
echo "::"
echo -e ":: Configuration du dépôt [oss-updates]... \c"
zypper addrepo $MIRROR/update/leap/$VERSION/oss oss-updates >> $LOG 2>&1
ok

# Configuration du dépôt [non-oss-updates]
echo "::"
echo -e ":: Configuration du dépôt [non-oss-updates]... \c"
zypper addrepo $MIRROR/update/leap/$VERSION/non-oss non-oss-updates >> $LOG 2>&1
ok

# Configuration du dépôt [nvidia]
echo "::"
echo -e ":: Configuration du dépôt [nvidia]... \c"
zypper addrepo $NVIDIA/opensuse/leap/$VERSION nvidia >> $LOG 2>&1
ok

# Configuration du dépôt [packman]
echo "::"
echo -e ":: Configuration du dépôt [packman]... \c"
zypper addrepo --priority 90 $PACKMAN packman >> $LOG 2>&1
ok

# Configuration du dépôt [dvdcss]
echo "::"
echo -e ":: Configuration du dépôt [dvdcss]... \c"
zypper addrepo $DVDCSS dvdcss >> $LOG 2>&1
ok

# Synchronisation et import des clés GPG
echo "::"
echo -e ":: Synchronisation et import des clés GPG... \c"
zypper --gpg-auto-import-keys refresh >> $LOG 2>&1
ok

# Mise à jour des paquets
echo "::"
echo -e ":: Mise à jour des paquets... \c"
zypper --non-interactive update --allow-vendor-change >> $LOG 2>&1
ok

echo

exit 0

