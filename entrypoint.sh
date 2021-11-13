#!/bin/bash

# AUTHOR      : avimehenwal
# DATE        : 13-Nov-2021
# PURPOSE     : RPM test script
# FILENAME    : test-script.sh
#
# Long problem description

BUILD_LOG=build.log

tito build --rpm --test | tee ${BUILD_LOG}

RPM=$(awk 'END{print $2}' ${BUILD_LOG})
echo "RPM => $RPM"
[ -f "$RPM" ] && echo "RPM exists ==> $RPM" || echo "RPM DOES NOT Exist ==> $RPM"

BEFORE="before = $(ls /usr/bin | wc)"
dnf localinstall -y ${RPM}
AFTER="after = $(ls /usr/bin | wc)"

whoami
git-insight

echo -e "$BEFORE \n $AFTER"
# END
