#! /bin/bash
#run this after root reinstall, from desktop of your home folder
echo: "This script will not work unless run from the Desktop folder of the user who ran the backup script. (Hint, look for ./yourrootpartition.txt and yourhomepartition.txt"
YOURROOTPARTITION="$( cat ./yourrootpartition.txt )"
YOURHOMEPARTITION="$( cat ./yourhomepartition.txt )"
# Add additional repositories
REPOLIST="$( cat ./repolist.txt )"
PKGLIST="$( cat ./pkglist.txt )"
#update sources list
sudo apt-get update
sudo apt-get dist-upgrade
sudo apt-add-repository $REPOLIST -y
sudo apt-get install $PKGLIST -y
