#!/usr/bin/bash

MDATA_EDITOR="exiftool -overwrite_original_in_place"

if [ "$*" == "" ]
then
    echo "Error: Must provide list of pdf files. Exiting..."
    exit 1
fi

# Change here the new metadata to use
DOC_AUTHOR="SGIC Escuela Politécnica Superior UAH"
DOC_TITLE="SGIC EPS-UAH document"
DOC_SUBJECT="SGIC EPS-UAH"
DOC_CREATOR=$DOC_AUTHOR

# For the backup file creation
DATE=`date +%C%y%m%d%H%M%S`

for f in $*
do
    if [ ! -f $f ]
    then
        echo "Error: provided file [$f] does not exist. Will continue..."
    else
        # Backup file
        BASENAME=`basename $f`
        DIRNAME=`dirname $f`
        PDF_BACKUP_FILE=$DIRNAME/$DATE-$BASENAME
        echo "Processing [$f], backing it up to [$PDF_BACKUP_FILE]..."
        cp $f $PDF_BACKUP_FILE

        # Modify metadata
        $MDATA_EDITOR -Title="$DOC_TITLE" -Author="$DOC_AUTHOR" -Subject="$DOC_SUBJECT" -Creator="$DOC_CREATOR" $f
    fi

done
