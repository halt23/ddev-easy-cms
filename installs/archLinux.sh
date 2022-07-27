#!/bin/bash

# Author: Sam Maas

# check if user is root

if [ "$(id -u)" = 0 ]; then
	echo "################################"
	echo "Do not run this script as root."
	echo "script will now exit"
	echo "###############################"
	exit 1
fi

# setup docker 
echo "#################"
echo "installing docker"
echo "#################"
sudo pacman -S --noconfirm --needed docker 
sudo systemctl enable docker 
sudo systemctl start docker

# just to be sure the group exist 
echo "#####################"
echo "creating docker group"
echo "#####################"

sudo groupadd docker
# adding user to docker group
echo "################################"
echo "lets add you to the docker group"
echo "################################"
sudo usermod -aG docker $USER
# installing zenity
echo "installing zenity"
sudo pacman -S --noconfirm --needed zenity 

package="ddev"
# checking aur helper and installing ddev 
echo "###############"
echo "installing ddev"
echo "###############"
if pacman -Qi yay &> /dev/null; then
	yay -S --noconfirm --needed $package

elif pacman -Qi trizen &> /dev/null; then
	trizen -S --noconfirm --needed --noedit $package

else 
	echo "##################################"
	echo "trizen or pacman are not installed"
	echo "please install trizen or pacman"
	echo "###############################"
	echo "script wil now exit..."
	exit 1

fi
echo "#############"
echo  "add ca certs"
echo "#############"
mkcert -install

sleep 1
echo "#######################"
echo "Now reboot your system."
echo "#######################"