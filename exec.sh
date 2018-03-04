#!/bin/bash

if [[ $EUID -ne 0 ]]; then
   echo "This script must be run using sudo" 1>&2
   exit 1
fi


if [ -n "${1}" ]; then
    # Setup root password
    DOMAIN="${1}" 
else
    echo "Usage:"
    echo "  Please put domain name: ${0} <domain name> " 1>&2
    exit 1
fi

sudo cp default.nginx /etc/nginx/sites-available/${DOMAIN}
sudo sed -i "s/default/${DOMAIN}/" /etc/nginx/sites-available/${DOMAIN}
sudo ln -s /etc/nginx/sites-available/${DOMAIN} /etc/nginx/sites-enabled/

sudo service nginx restart


echo "Successfully create a domain named : ${1}"