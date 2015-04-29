#!/bin/sh

# get the login info
# ~/.uwrc should look like:
# user=username
# password=password

source ~/.uwrc

SRC_FILE=$1

HOST=vergil.u.washington.edu
URL=${user}@${HOST}:/da00/d24/$user/public_html/files/

/usr/bin/rsync -ratlz --rsh="/usr/local/bin/sshpass -p $password ssh -o StrictHostKeyChecking=no -l $user" --delete $SRC_FILE $URL && afplay "/System/Library/Sounds/Purr.aiff"
