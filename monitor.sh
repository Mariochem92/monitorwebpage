#!/bin/bash

# monitor.sh - Monitorare cambiamenti all'interno del testo di una pagina web

#URL="https://www.ansa.it"
URL=$(zenity --entry --text "Enter the URL you intend to recursively update:" --title "Update Web Page" --entry-text=""); echo $URL

curl $URL -L --compressed -s > old.html

for (( ; ; )); do
html2text  old.html > before.html
curl $URL -L --compressed -s > new.html
html2text  new.html > after.html

DIFF=$(diff before.html after.html)
if [ "$DIFF" != "" ]
then
#ffplay /home/mario/Downloads/sw.mp3
zenity --info --width 300 --text='The page you have chosen to monitor has been updated right now. Go check!! ' 
else
date
fi
rm old.html
mv new.html old.html
done 
