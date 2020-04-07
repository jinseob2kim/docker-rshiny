#!/bin/bash

## Set defaults for environmental variables in case they are undefined
USER=${USER:=js}
PASSWORD=${PASSWORD:=js}
ROOT=${ROOT:=TRUE}


## USER ADD 
adduser ${USER} --gecos 'First Last,RoomNumber,WorkPhone,HomePhone' --disabled-password 
sh -c 'echo ${USER}:${PASSWORD} | sudo chpasswd' 

## Package library: /usr/local/lib/R/site-library
addgroup ${USER} staff


if [ "$ROOT" == "TRUE" ]
  then
    usermod -aG sudo ${USER}
fi    
    


## Shiny-server setting
sed -i "s/srv\/shiny-server/home\/${USER}\/ShinyApps/g" /etc/shiny-server/shiny-server.conf 
sed -i "s/var\/log\/shiny-server/home\/${USER}\/ShinyApps\/log/g" /etc/shiny-server/shiny-server.conf
sed -i "s/shiny\;/${USER}\;/g" /etc/shiny-server/shiny-server.conf


## ShinyApps
#git clone https://github.com/jinseob2kim/ShinyApps /home/${USER}/ShinyApps
cp -R /srv/shiny-server /home/${USER}/ShinyApps
chmod -R 777 /home/${USER}/ShinyApps

## Encoding
echo -e LANG=en_US.UTF-8 > /home/shiny/.Renviron
echo -e LANG=en_US.UTF-8 > /home/${USER}/.Renviron


## Permission
groupadd shiny-apps 
usermod -aG shiny-apps ${USER} 
usermod -aG shiny-apps shiny 
cd /home/${USER}/ShinyApps 
chown -R ${USER}:shiny-apps . 
chmod g+w . && \
chmod g+s .

    

