#!/bin/bash

user="leo.etcheverry-haasis@orange.fr" # Here is the orange username
passwd="leo22121995" # And here is the password

echo "Attempt to reconnect to orange gateway with '$user' as username and '$passwd' as password..."
curl --URL 'https://hautdebitmobile.orange.fr:8443/home/wassup' --data "username=$user" --data "password=$passwd" --data "isCgu=checked"

