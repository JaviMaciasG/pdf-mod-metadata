#!/usr/bin/bash

MDATA_EDITOR="exiftool -overwrite_original_in_place"
VERBOSE=1

if [ "$*" == "" ]
then
    echo "Error: Must provide list of pdf files. Exiting..."
    exit 1
fi

if [ "`which $MDATA_EDITOR`" == "" ]
then
    echo "Error: Must have exiftool installed. Exiting..."
    exit 2
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
        PDF_BACKUP_FILE=$DATE-$f
        echo "Processing [$f], backing it up to [$PDF_BACKUP_FILE]..."
        cp $f $PDF_BACKUP_FILE

        if [ $VERBOSE -ne 0 ]
        then
            ORIG_AUTHOR=`$MDATA_EDITOR $f -Author | cut -f 2- -d ":" | cut -f 2- -d " "`
            ORIG_TITLE=`$MDATA_EDITOR $f -Title | cut -f 2- -d ":" | cut -f 2- -d " "`
            ORIG_SUBJECT=`$MDATA_EDITOR $f -Subject | cut -f 2- -d ":" | cut -f 2- -d " "`
            ORIG_CREATOR=`$MDATA_EDITOR $f -Creator | cut -f 2- -d ":" | cut -f 2- -d " "`

            echo "  Changing author  from [$ORIG_AUTHOR] to [$DOC_AUTHOR]"
            echo "  Changing title   from [$ORIG_TITLE] to [$DOC_TITLE]"
            echo "  Changing subject from [$ORIG_SUBJECT] to [$DOC_SUBJECT]"
            echo "  Changing creator from [$ORIG_CREATOR] to [$DOC_CREATOR]"
        fi

        # Modify metadata
        $MDATA_EDITOR -Title="$DOC_TITLE" -Author="$DOC_AUTHOR" -Subject="$DOC_SUBJECT" -Creator="$DOC_CREATOR" $f
    fi
done
