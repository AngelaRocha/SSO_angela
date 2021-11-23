#!/bin/bash
#Author: Angela Maria Rocha Valdez - Examen Práctico SSO 062
#Student ID: 1916728
# 1.Script should be able to identify if the OS is or CentOS v7 or CentOS v8
version=$(grep '^VERSION_ID' /etc/os-release)
if  [[ $version = 'VERSION_ID="7"' ]]; then
        sleep 3
        echo "Your OS version is $(cat /etc/centos-release)"
elif [[ $version = 'VERSION_ID="8"' ]]; then
        sleep 3
        echo "Your OS version is $(cat /etc/centos-release)"
fi
# 2. Script shouls install clamav antivirus. If the antivirus is already installed or running,
#    the script should stop and uninstall the software before it install a fresh one
lista=$(yum list -q installed | grep '^clamav')
if [[ $lista = "" ]]; then
        echo "ClamAV AntiVirus is not installed in your system. The installations is going to start."
        sleep 3
        sudo yum -y install https://www.clamav.net/downloads/production/clamav-0.104.1.linux.x86_64.rpm
        echo "ClamAV successfully installed."
        else
        sleep 3
        echo "ClamAV is already installed in the system. It will be deleted and reinstalled to update the version."
        sudo yum -y erase clamav*
        sleep 3
        echo "ClamAV succesfully deleted."
        sleep 3
        echo "The installation for the version update begins."
        sudo yum -y install https://www.clamav.net/downloads/production/clamav-0.104.1.linux.x86_64.rpm
        sleep 3
        echo "ClamAV successfully installed with the update version."
fi
# 3. Script should install EPEL repositories only for CentOS v7 servers.
if  [[ $version = 'VERSION_ID="7"' ]];
then
        echo "You have CentOS 7, the installation of EPEL is going to start."
        sudo yum -y install https://dl.fedoraproject.org/pub/epel/epel-release-latest-7.noarch.rpm
        echo "EPEL successfully installed."
if [[ $cclamav = "" ]]; then
        echo "ClamAV AntiVirus is not installed in your system.The installations is going to start."
        sudo yum -y install clamav
        echo "ClamAV successfully installed."
        else
        echo "ClamAV is already installed in the system. It will be deleted and reinstalled to update the version."
        sudo yum -y erase clamav*
        sleep 3
        echo "ClamAV succesfully deleted."
        sleep 3
        echo "The installation with the version update begins."
        sudo yum -y install clamav
        sleep 3
        echo "ClamAV successfully installed with the update version."
fi
# 4. Script should be capable to update all packages having an available update in the repositories.
if [[ $(yum check-update -q | awk '(print$1)') = ""  ]];
then
        sleep 3
        echo "There are no packages to update."
else
        sleep 3
        echo "The packages with available updates are: $(yum check-update -q | awk '{print$1}')"
        sudo yum check-update -q | awk '(print$1)'
        sleep 3
        echo "The update is going to start."
        sudo yum -y update
        sleep 3
        echo "Packages successfully updated."
fi
exit 0