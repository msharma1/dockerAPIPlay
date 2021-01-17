#!/bin/bash

#Below section collects data like IP address, City, Region#
if [ $# -eq 0 ]
then
    echo "No arguments supplied, taking current system IP and showing data as per the current system location"
    ip_final=$(curl -ksS  'https://ipinfo.io/' | jq '.ip')
    city=`curl -ksS  "https://ipinfo.io/" | jq '.city'`
    region=`curl -ksS  "https://ipinfo.io/" | jq '.region'`
else
    echo "IP passed is $1, showing data as per the $1 system location"
    ip_final=$1
    city=`curl -ksS  "https://ipinfo.io/$ip_final" | jq '.city'`
    region=`curl -ksS  "https://ipinfo.io/$ip_final" | jq '.region'`
fi

#NOTE: Below section uses an API that is not as per the question (api.darksky.net)
#The issue with api.darksky.net is that it is not accepting new users and I could not generate the API key
#Reference: https://arstechnica.com/gadgets/2020/08/android-version-of-popular-dark-sky-weather-app-shuts-down/

#Hence I used azure API
echo "Weather forecast for $ip_final ($city):"
curl -ksS  "https://thisdavej.azurewebsites.net/api/weather/forecast?loc=$city,%20$region&deg=C" | jq -r '.[] | "\(.date) : \(.skytextday)\n"'
echo $output

