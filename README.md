# Simple script to modify some PDF metadata

Modifies PDF metadata (for EPS-UAH SGIC). There are two scripts here (`go.mod-metadata.sh` and `go.mod-metadata-simple.sh`). In the `simple` version there are fewer checks and does not provide a verbose output. 

The scripts do the modification in place, after generating a backup of the original file (named as DATE-filename.pdf).

It was created for the EPS-UAH SGIC team.

## Requirements

+ bash
+ exiftool

## Run

Just call it with any number of pdf files as arguments:

`$ ./go.mod-metadata.sh file1.pdf file2.pdf`


