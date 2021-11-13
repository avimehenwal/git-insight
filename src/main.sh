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
DEFAULT_LOGS=10

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
# SYSLOG "debug" "debug msg sent from syslog API variant 1"

# test: syslog API 2
# EMERG "some emergency msg"
# ALERT "raise an alert"
# CRITICAL "this is critical"
# ERROR "fuck! it errored out"
# WARN "just a warning man"
# NOTICE "la la la notice ...."
# INFO "application info"
# DEBUG "monitoring info"

# GIT-FUNCTIONS
git_trend() {
  local NUM_COMMITS=${1:-${DEFAULT_LOGS}}
  git log --date=short --pretty=@%ad --shortstat -${NUM_COMMITS} |
    tr "filechangedinsertionsdeletions()+" " " |
    sed -e 's/[ ]*//g' -e 's/-$//g' |
    tr "\n" " " |
    tr "@" "\n" |
    tail -n +2 |
    awk 'BEGIN{RS="\n";FS=","; \
        print"@ Additions,Deletions"} { \
        if($2=="")print$1" 0,0,0"; \
        else if($3=="")print$0",0"; \
        else print$0}'
}

git_trend_graph() {
  local NUM_COMMITS=${1:-${DEFAULT_LOGS}}
  git_trend | termgraph --stacked --color {blue,red} \
    --title "Number of Files changed::Additions/deletions in last $NUM_COMMITS commits"
}

# MAIN
git_trend_graph
# git_trend_graph 15
# git_trend_graph 15000

# END
