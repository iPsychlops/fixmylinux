#! /bin/bash
#run this before reinstall OS on root to back up repos and packages
sudo lsblk -o NAME,FSTYPE,SIZE,MOUNTPOINT,LABEL
echo "What is your userid? Use same userid as prior to reinstall"
read USERID
echo "Which device contains your root partition (see above)? Use format: <sdXY> e.g. sda6; /dev/ is assumed."
read ROOTPARTITIONLABEL
echo "confirming" $ROOTPARTITIONLABEL "(press ctrl+c to cancel)"
echo "Which device contains your home partition (see above)? Use format: <sdXY> e.g. sda7; /dev/ is assumed."
read HOMEPARTITIONLABEL
echo "confirming" $HOMEPARTITIONLABEL "(press ctrl+c to cancel)"
sudo blkid -s UUID -o value /dev/$ROOTPARTITIONLABEL > ./yourrootpartition.txt
sudo blkid -s UUID -o value /dev/$ROOTPARTITIONLABEL > /media/ubuntu/$YOURHOMEPARTITION/$USERID/Desktop/yourrootpartition.txt
YOURROOTPARTITION="$( cat ./yourrootpartition.txt )"
echo "The UUID of your your root partition is" 
cat ./yourrootpartition.txt
sudo blkid -s UUID -o value /dev/$HOMEPARTITIONLABEL > ./yourhomepartition.txt
sudo blkid -s UUID -o value /dev/$HOMEPARTITIONLABEL > /media/ubuntu/$YOURHOMEPARTITION/$USERID/Desktop/yourhomepartition.txt
YOURHOMEPARTITION="$( cat ./yourhomepartition.txt )"
echo "The UUID of your your home partition is" 
cat ./yourhomepartition.txt
echo "Backing up repos and user-installed apps..."
#Make local and 2nd backups, one in  your/home/folder and one in temp local directory

sudo grep -r --include '*.list' '^deb ' /media/ubuntu/$YOURROOTPARTITION/etc/apt/ | sed -re 's/^\/etc\/apt\/sources\.list((\.d\/)?|(:)?)//' -e 's/(.*\.list):/\[\1\] /' -e 's/deb http:\/\/ppa.launchpad.net\/(.*?)\/ubuntu .*/ppa:\1/' > /media/ubuntu/$YOURHOMEPARTITION/$USERID/Desktop/repolist.txt && sudo apt-mark showmanual > /media/ubuntu/$YOURHOMEPARTITION/$USERID/Desktop/pkglist.txt
sudo grep -r --include '*.list' '^deb ' /media/ubuntu/$YOURROOTPARTITION/etc/apt/ | sed -re 's/^\/etc\/apt\/sources\.list((\.d\/)?|(:)?)//' -e 's/(.*\.list):/\[\1\] /' -e 's/deb http:\/\/ppa.launchpad.net\/(.*?)\/ubuntu .*/ppa:\1/' > ./repolist.txt && sudo apt-mark showmanual > ./pkglist.txt
