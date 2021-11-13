#!/usr/bin/bash

# AUTHOR      : avimehenwal
# DATE        : 13-Nov-2021
# PURPOSE     : git-insight
# FILENAME    : main.sh
#
# beautifil git insights

APP_ID="67feb6ffbaf24c5cbec13c008dd72309"
APP_TAG="git-insight"
declare -A PRIORITY

PRIORITY=(["emerg"]="0" ["alert"]="1" ["crit"]="2" ["err"]="3" ["warn"]="4" ["notice"]="5" ["info"]="6" ["debug"]="7")

SYSLOG() {
  local LOG_LEVEL=$1
  shift
  local MSG=$@

  logger --journald <<end
SYSLOG_IDENTIFIER=${APP_TAG}
PRIORITY=${PRIORITY[$LOG_LEVEL]}
MESSAGE_ID=${APP_ID}
MESSAGE=${MSG}
end
}
EMERG() {
  SYSLOG "emerg" $@
}
ALERT() {
  SYSLOG "alert" $@
}
CRITICAL() {
  SYSLOG "critical" $@
}
ERROR() {
  SYSLOG "err" $@
}
WARN() {
  SYSLOG "warn" $@
}
NOTICE() {
  SYSLOG "notice" $@
}
INFO() {
  SYSLOG "info" $@
}
DEBUG() {
  SYSLOG "debug" $@
}

# test: syslog API 1
SYSLOG "debug" "debug msg sent from syslog API variant 1"

# test: syslog API 2
EMERG "some emergency msg"
ALERT "raise an alert"
CRITICAL "this is critical"
ERROR "fuck! it errored out"
WARN "just a warning man"
NOTICE "la la la notice ...."
INFO "application info"
DEBUG "monitoring info"

# MAIN
echo "2007    183.32
2008    231.23
2009     16.43
2010     50.21
2011    508.97
2012    212.05
2014    1.0
" | termgraph

# END
