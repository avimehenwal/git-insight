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
DEFAULT_COMMITS=10
DEFAULT_LEADERS=10
DEFAULT_TOP_FILES=8

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
git_log_length() {
  git rev-list --all --count
}
git_commit() {
  local NUM_COMMITS=${1:-${DEFAULT_COMMITS}}
  git log --date=short --pretty=format:%ad -${NUM_COMMITS} |
    sort --reverse |
    uniq -c |
    awk '{print$2" "$1}'
}
git_top_files_modified() {
  local TOP_FILE=${1:-${DEFAULT_TOP_FILES}}
  git log --pretty=format: --name-only |
    sort |
    uniq -c |
    sort -rg |
    tail -n +2 |
    head -${TOP_FILE}
}
git_branch_commits() {
  for item in $(git branch --remote --list --no-color |
    grep --invert-match HEAD |
    sed -e 's/[ ]*//'); do
    # echo -e "git rev-list --count $item"
    local count=$(git rev-list --count $item)
    echo "$item, $count"
  done
}

# GIT-GRAPHS
git_trend_graph() {
  local NUM_COMMITS=${1:-${DEFAULT_LOGS}}
  local BG=4
  local FG=15
  local TITLE="Number of Files changed::Additions/deletions in last $(tput bold)${NUM_COMMITS}$(tput setab ${BG})$(tput setaf ${FG}) commits"
  echo -e "\n$(tput setab ${BG})$(tput setaf ${FG})  ${TITLE}  $(tput sgr0)"
  git_trend | termgraph --stacked --color {cyan,red}
}
git_log_calendar() {
  local GIT_LOG_LENGTH=$(git_log_length)
  local BG=8
  local FG=15
  local TITLE="Trends over the total of $(tput bold)$(tput blink)${GIT_LOG_LENGTH} commits"
  echo -e "\n$(tput setab ${BG})$(tput setaf ${FG})  ${TITLE}  $(tput sgr0)"
  git_trend ${GIT_LOG_LENGTH} |
    tail -n +2 |
    cut --delimiter=',' -f1 |
    termgraph --calendar --color green
}
git_commit_graph() {
  local NUM_COMMITS=${1:-${DEFAULT_COMMITS}}
  git_commit ${NUM_COMMITS} |
    termgraph --color magenta --title "#Commit history for last ${NUM_COMMITS} logs"
}
git_leaderboard() {
  local NUM=${1:-${DEFAULT_LEADERS}}
  git shortlog --summary --numbered |
    head -${NUM} |
    awk '{print $2 $3 $4, $1}' |
    termgraph --color yellow --title "LEADERBOARD:: Top ${NUM} Contributors"

}
git_hot_files_graph() {
  local TOP_FILE=${1:-${DEFAULT_TOP_FILES}}
  git_top_files_modified ${TOP_FILE} |
    awk '{print$2", "$1}' |
    termgraph --color blue --title "Most frequently updated files"
}
branch_comparison_graph() {
  local TITLE="Number of commits on each branch"
  git_branch_commits | termgraph --color black --title "${TITLE}"
}

# TEST
# test: 1
# git_trend_graph
# git_trend_graph 15
# git_trend_graph 15000

# MAIN
git_commit_graph
git_trend_graph
git_log_calendar
git_leaderboard
git_hot_files_graph
branch_comparison_graph

# END
