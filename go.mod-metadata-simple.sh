#!/usr/bin/bash

MDATA_EDITOR="exiftool -overwrite_original_in_place"

if [ "$*" == "" ]
then
    echo "Error: Must provide list of pdf files. Exiting..."
    exit 1
fi

DOC_AUTHOR="SGIC Escuela Politécnica Superior UAH"
DOC_TITLE="SGIC EPS-UAH document"
DOC_SUBJECT="SGIC EPS-UAH"
DOC_CREATOR=$DOC_AUTHOR

DATE=`date +%C%y%m%d%H%M%S`

for f in $*
do
    # Backup file
    PDF_BACKUP_FILE=$DATE-$f
    echo "Processing [$f], backing it up to [$PDF_BACKUP_FILE]..."
    cp $f $PDF_BACKUP_FILE

    # Modify metadata
    TMP_FILE=`mktemp`
    $MDATA_EDITOR -Title="$DOC_TITLE" -Author="$DOC_AUTHOR" -Subject="$DOC_SUBJECT" -Creator="$DOC_CREATOR" $f

done
