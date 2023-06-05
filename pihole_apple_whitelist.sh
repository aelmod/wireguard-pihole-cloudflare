#!/bin/bash
# 20211117: foresthus - https://discourse.pi-hole.net/t/commonly-whitelisted-domains/212/147

FETCHURL="https://support.apple.com/en-us/HT210060"
cd /tmp
rm -f *pihole*.txt

echo "######################################################################"
echo "All files in /tmp/ with someting in the name called *pihole*.txt is deleted."
echo "We are fetching the fqdns from this URL: "$FETCHURL "to generate two files for whitelisting apple-fqdns and apple white-regex in a pihole commandline text."
echo "######################################################################"

curl $FETCHURL |grep "</tr><tr><td>" | cut -d "<" -f4 |cut -d ">" -f2 | grep -v "/" | grep -v "*." | tr '\n' ' ' | sed -e "s/.*/pihole -w &/" > /tmp/`date '+%Y.%m.%d-%H.%M'`_pihole_whitelist_apple.urls.txt
curl $FETCHURL |grep "</tr><tr><td>" | cut -d "<" -f4 |cut -d ">" -f2 | grep -v "/" | grep "*." | tr '\n' ' ' | sed -e "s/.*/pihole --white-regex &/" > /tmp/`date '+%Y.%m.%d-%H.%M'`_pihole_regex_apple.urls.txt

echo "######################################################################"
echo "pihole whitelist and the pihole white-regex-list is placed under /tmp/"
echo "######################################################################"
ls -ltr /tmp/*pihole*.txt