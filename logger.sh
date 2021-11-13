#!/bin/bash
#
# AUTHOR  : avimehenwal
# CREATED : Sat Nov 13 04:55:12 PM CET 2021
# PURPOSE :

# logger --tag "APP-LABEL" --id=$$

for num in  {1..7}
do

logger --journald <<end
MESSAGE_ID=67feb6ffbaf24c5cbec13c008dd72309
MESSAGE=The dogs bark, but the caravan goes on.
PRIORITY=${num}
SYSLOG_IDENTIFIER=APP-LABEL
end

done


# END
