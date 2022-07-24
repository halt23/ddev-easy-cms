# ddev-Easy-cms 

**Ddev easy cms is a easy way to install a cms into ddev.** 

- [ddev-Easy-cms](#ddev-easy-cms)
  - [how it works](#how-it-works)
  - [install](#install)
    - [requirements](#requirements)
    - [download and usage](#download-and-usage)

## how it works

1. Get the code.
2. Read the code.
3. Install Docker Ddev and Zenity.
4. Run ddev-easy-cms.sh
5. After just 3 clicks you have a functional  cms.  

## install

### requirements

- ddev
- docker
- zenity

to get the requirements follow the guides for your os/distro here:
[ddev](https://ddev.readthedocs.io/en/stable/users/install/) and [docker](https://docs.docker.com/get-docker/)

We also made somme scripts to automate the installation
we now have scripts for:

- arch Linux (and other arch based distro's).

More distro's/operating systems wil come soon. 

Users that see there distro or os listed above can find a install script for there distro or os in:
```
/installs/distro,os
```
Distro's/operating systems that are not listed should follow the links of docker and ddev provided above.

### download and usage


```
# download repo
git clone https://github.com/halt23/ddev-easy-cms.git

cd ddev-easy-cms
# Run install script if one for your distro else use documentation.

cd installs/
./os-or-distro-script.sh

cd ..
# Make your first project using ddev Easy cms by running:

./ddev-easy-cms.sh

```




  




