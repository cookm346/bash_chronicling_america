#!/bin/bash

#download JSON file with file data
wget "https://chroniclingamerica.loc.gov/ocr.json" -O ocr.json

#get file names from JSON data and remove quotes around the names
jq ".ocr | .[].name" ocr.json | tr -d \" > files

#sort urls and download log
sort -o files files
sort -o downloaded.log downloaded.log

#loop through files that have yet to be downloaded
for i in $(comm files downloaded.log -23)
do
        #download tar.bz2 file
        cd ./downloads
        wget http://chroniclingamerica.loc.gov/data/ocr/$i -O $i
        echo LOG: downloaded: http://chroniclingamerica.loc.gov/data/ocr/$i

        #strip off ".tar.bz2" for folder name of extreacted files
        file_name=${i%.tar.bz2}
        cd ../

        mkdir ./text/$file_name
        echo LOG: created: ./text/$file_name directory

        #unpack the tar archive from the downloads folder to the text folder
        tar -xf ./downloads/$i -C ./text/$file_name
        echo LOG: unpacked: ./downloads/$i

        #delete any files that are not text (xml files for example)
        find ./text/$file_name -type f ! -name '*ocr.txt' -delete
        echo LOG: deleted: non-txt files form ./text/$file_name

        #remove tar.bz2 file
        rm ./downloads/$i
        echo LOG: deleted: ./downloads/$i

        #update download log
        echo $i >> downloaded.log

        #update text_files
        find ./text/$file_name -type f -name '*ocr.txt' >> text_files
        echo LOG: updating txt files list from ./text/$file_name

	#add sleep for 1 minute
	sleep 60s
done
