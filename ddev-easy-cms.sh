#!/bin/bash

# Author: Sam Maas

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

	dir=`zenity --entry --text="enter name of project directory(do not enter a path)" --title="project directory"`
	path=`zenity --file-selection --directory --title="Select location to initialize the project directory $dir"`
	cms=`zenity --forms --title "Select cms" --add-combo "chose cms." --combo-values "Typo3|Drupal|Wordpress"`
	path_dir="$path/$dir"

}


setup_cms(){

	if [[ $cms = "Wordpress" ]]; then

		mkdir -p $path_dir
		cd $path_dir
		ddev config --project-type=wordpress
		ddev start
		ddev wp core download
		ddev launch
		

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
		ddev launch


	elif [[ $cms = "Typo3" ]]; then
	
		mkdir -p $path_dir
		cd $path_dir
		ddev config --project-type=typo3 --docroot=public --create-docroot
		ddev start
		ddev composer create "typo3/cms-base-distribution:^11"
		cd public
		touch FIRST_INSTALL
		cd ..
		ddev launch

	else
		echo "no cms selected re run the script and select one from drop down"
		exit 1


	fi


}

initial_setup
setup_vars
setup_cms
