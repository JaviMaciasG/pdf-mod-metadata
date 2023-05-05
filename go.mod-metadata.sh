#!/usr/bin/env sh


MDATA_EDITOR=exiftool
PDFTK=pdftk
HAS_PDFTK=1

if [ "`which $MDATA_EDITOR`" == "" ]
then
    echo "Error: Must have exiftool installed. Exiting..."
    exit 2
fi
if [ "`which $PDFTK`" == "" ]
then
    echo "Warning: [$PDFTK] not installed. Will continue as it is not required but funcionality is reduced"
    HAS_PDFTK=0
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

    if [ $HAS_PDFTK -eq 1 ]
    then
        ORIG_AUTHOR=`pdftk $f dump_data | awk -F: '/^InfoKey: Author/ {getline; gsub(/^[ \t]+/,"",$0); print $0}'`
        ORIG_TITLE=`pdftk $f dump_data | awk -F: '/^InfoKey: Title/ {getline; gsub(/^[ \t]+/,"",$0); print $0}'`
        ORIG_SUBJECT=`pdftk $f dump_data | awk -F: '/^InfoKey: Subject/ {getline; gsub(/^[ \t]+/,"",$0); print $0}'`
        ORIG_CREATOR=`pdftk $f dump_data | awk -F: '/^InfoKey: Creator/ {getline; gsub(/^[ \t]+/,"",$0); print $0}'`

        echo "  Changing author  from [$ORIG_AUTHOR] to [$DOC_AUTHOR]"
        echo "  Changing title   from [$ORIG_TITLE] to [$DOC_TITLE]"
        echo "  Changing subject from [$ORIG_SUBJECT] to [$DOC_SUBJECT]"
        echo "  Changing creator from [$ORIG_CREATOR] to [$DOC_CREATOR]"
    fi

    # Modify metadata
    TMP_FILE=`mktemp`
    $MDATA_EDITOR -Title="$DOC_TITLE" -Author="$DOC_AUTHOR" -Subject="$DOC_SUBJECT" -Creator="$DOC_CREATOR" $f

done
