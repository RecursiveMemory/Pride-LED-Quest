#!/bin/sh
# This script does things to let users change their LED flavor


# Is this to spec? No. Does it work? Yeah. Thank you relative directory!
settingslocation="settings.ini"

# Get the settings lol
setting=$( cat $settingslocation )

# Options (Place options here and in the for loop below)
o1="pride"
o2="transgender"
o3="genderfluid"

# DO NOT CHANGE THIS FROM ZERO
settingfound="0"

# I love naming things in funny ways. Make sure to put additional options here.
for crap in $o1 $o2 $o3; do

    if [ $settingfound = "1" ]
    then newsetting=$crap
    settingfound="2"
    break
    fi

    if [ $setting = $crap ]
    then settingfound="1"
    fi
done


# Default to pride should something go wrong or not be found
if [ $settingfound = "0" ] || [ $settingfound = "1" ]
then
newsetting="pride"
fi

# Inform user of their choices
echo "New setting is: ${newsetting}"

# Write to the settings file
echo "${newsetting}" > $settingslocation
