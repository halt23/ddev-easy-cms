#!/bin/bash

# Author: Sam Maas

cancel=false
CWD=$(pwd)


rc_check() {

	case $? in
		 1)
			
			zenity --question \
			--text="Are you sure you wish to quit?"
			if [[ $? == 0 ]]; then
				exit 1
			else
				setup_vars

			fi
	esac

}


initial_setup(){

	if ! command -v docker >/dev/null; then
		echo "########################################################################"
		echo "This script requires docker to be installed: please install docker first"
		echo "########################################################################"
		exit 1

	else 
		echo "docker is installed.."
	fi

	if ! command -v ddev >/dev/null; then
		echo "####################################################################"
		echo "This script requires ddev to be installed: please install ddev first"
		echo "####################################################################"
		exit 1

	else
		echo "ddev is installed.."

	fi

if ! command -v zenity >/dev/null; then
		echo "########################################################################"
		echo "This script requires zenity to be installed: please install zenity first"
		echo "########################################################################"
		exit 1

	else
		echo "zenity is installed.."

	fi

	echo "continuing..."
	sleep 2


}

setup_vars(){

	

	while [[ $cancel == false ]]; do

		dir=`zenity --entry --text="enter name of project directory(do not enter a path)" --title="project directory"`
		rc_check
		path=`zenity --file-selection --directory --title="Select location to initialize the project directory $dir"`
		rc_check
		cms=`zenity --forms --title="Select cms" --text=" " --add-combo "chose cms." --combo-values "Typo3|Drupal|Wordpress"`
		rc_check
		path_dir="$path/$dir"
		url="https://$dir.ddev.site"

		cancel=true

	done

}


setup_cms(){

	if [[ $cms = "Wordpress" ]]; then

		mkdir -p $path_dir
		cd $path_dir
		ddev config --project-type=wordpress
		ddev start
		ddev wp core download
		cd $CWD
		source ./gui.sh
		

	elif [[ $cms = "Drupal" ]]; then
	
		mkdir -p $path_dir
		cd $path_dir
		ddev config --project-type=drupal9 --docroot=web --create-docroot
		ddev start
		ddev composer create "drupal/recommended-project" --no-install
		ddev composer require drush/drush --no-install
		ddev composer install
		ddev drush site:install -y
		ddev drush uli
		cd $CWD
		source ./gui.sh


	elif [[ $cms = "Typo3" ]]; then
	
		mkdir -p $path_dir
		cd $path_dir
		ddev config --project-type=typo3 --docroot=public --create-docroot
		ddev start
		ddev composer create "typo3/cms-base-distribution" --no-install -y
		ddev composer install
		cd public
		touch FIRST_INSTALL
		cd ..
		cd $CWD
		source ./gui.sh

	else
		echo "no cms selected re run the script and select one from drop down"
		exit 1


	fi


}



initial_setup
setup_vars
setup_cms


