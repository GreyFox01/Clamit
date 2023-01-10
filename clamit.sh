#!/bin/bash
echo "This is a ClamAV virus scan of your entire system. ClamAV will update, then run a full scan."
echo "After the scan, you will be asked if you choose to delete those files ClamAV discovered as infected."
echo "If you choose not to, you'll be politely escorted back to your command prompt."
echo "Sit back and enjoy the ride."
echo "Updating ClamAV..."
sudo systemctl stop clamav-freshclam
sudo freshclam
sudo systemctl start clamav-freshclam
echo "Running virus scan..."
#clamscan -r -i /
function clamremove {
  clamscan -r -i --remove=yes /
}
function yesorno {
        QUESTION=$1
        DEFAULT=$2
        if [ "$DEFAULT" = true ]; then
                OPTIONS="[Y/n]"
                DEFAULT="y"
            else
                OPTIONS="[y/N]"
                DEFAULT="n"
        fi
        read -p "$QUESTION $OPTIONS " -n 1 -s -r INPUT
        INPUT=${INPUT:-${DEFAULT}}
        echo ${INPUT}
        if [[ "$INPUT" =~ ^[yY]$ ]]; then
            ANSWER=true
        else
            ANSWER=false
        fi
}

yesorno "Do you want to delete the results from the scan?" true
DOIT=$ANSWER

if [ "$DOIT" = true ]; then clamremove
fi
