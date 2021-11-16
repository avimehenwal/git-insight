#!/usr/bin/zsh

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

GRAPHER=${HOME}/.local/bin/termgraph

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
data_git_trend() {
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
data_git_log_length() {
  git rev-list --all --count
}
data_git_commit() {
  local NUM_COMMITS=${1:-${DEFAULT_COMMITS}}
  git log --date=short --pretty=format:%ad -${NUM_COMMITS} |
    sort --reverse |
    uniq -c |
    awk '{print$2" "$1}'
}
data_git_top_files_modified() {
  local TOP_FILE=${1:-${DEFAULT_TOP_FILES}}
  git log --pretty=format: --name-only |
    sort |
    uniq -c |
    sort -rg |
    tail -n +2 |
    head -${TOP_FILE}
}
data_git_branch_commits() {
  for item in $(git branch --remote --list --no-color |
    grep --invert-match HEAD |
    sed -e 's/[ ]*//'); do
    # echo -e "git rev-list --count $item"
    local count=$(git rev-list --count $item)
    echo "$item, $count"
  done
}

# GIT-GRAPHS
graph_git_trend() {
  local NUM_COMMITS=${1:-${DEFAULT_LOGS}}
  local BG=4
  local FG=15
  local TITLE="Number of Files changed::Additions/deletions in last $(tput bold)${NUM_COMMITS}$(tput setab ${BG})$(tput setaf ${FG}) commits"
  echo -e "\n$(tput setab ${BG})$(tput setaf ${FG})  ${TITLE}  $(tput sgr0)"
  data_git_trend ${NUM_COMMITS} | ${GRAPHER} --stacked --color {cyan,red}
}
calendar_graph_git_log() {
  local GIT_LOG_LENGTH=$(data_git_log_length)
  local BG=8
  local FG=15
  local TITLE="Trends over the total of $(tput bold)$(tput blink)${GIT_LOG_LENGTH} commits"
  echo -e "\n$(tput setab ${BG})$(tput setaf ${FG})  ${TITLE}  $(tput sgr0)"
  data_git_trend ${GIT_LOG_LENGTH} |
    tail -n +2 |
    cut --delimiter=',' -f1 |
    ${GRAPHER} --calendar --color green
}
graph_git_commit() {
  local NUM_COMMITS=${1:-${DEFAULT_COMMITS}}
  data_git_commit ${NUM_COMMITS} |
    ${GRAPHER} --color magenta --title "#Commit history for last ${NUM_COMMITS} logs"
}
graph_git_leaderboard() {
  local NUM=${1:-${DEFAULT_LEADERS}}
  git shortlog --summary --numbered |
    head -${NUM} |
    awk '{print $2 $3 $4, $1}' |
    ${GRAPHER} --color yellow --title "LEADERBOARD:: Top ${NUM} Contributors"

}
graph_git_hot_files() {
  local TOP_FILE=${1:-${DEFAULT_TOP_FILES}}
  data_git_top_files_modified ${TOP_FILE} |
    awk '{print$2", "$1}' |
    ${GRAPHER} --color blue --title "Most frequently updated files"
}
graph_branch_comparison() {
  local TITLE="Number of commits on each branch"
  data_git_branch_commits | ${GRAPHER} --color black --title "${TITLE}"
}

# TEST
# test: 1
# graph_git_trend
# graph_git_trend 15
# graph_git_trend 15000

# MAIN
all_insights() {
  graph_git_commit
  graph_git_trend
  graph_git_leaderboard
  graph_git_hot_files
  graph_branch_comparison
  calendar_graph_git_log
  INFO "All graphs summary requested"
  exit 0
}

__usage="
${(U)APP_TAG} - get browser like colorful insights about a git repository on terminal

USAGE:
    ${APP_TAG}
    ${APP_TAG} [OPTIONS]
    ${APP_TAG} <subcommand>

OPTIONS:
    -h  --help                  display help

VALID SUBCOMMANDS:
    graph_git_commit            displays Commit history for last 10 logs'
    graph_git_trend             Number of Additions/deletions and files that changed'
    graph_git_leaderboard       Top 10 Contributors'
    graph_git_hot_files         Most frequently updated files'
    graph_branch_comparison     Number of commits on each branch'
    calendar_graph_git_log      Trends over the total number of commits on repo'

EXAMPLES:
    ${APP_TAG} --help
    ${APP_TAG} graph_git_commit 50
    ${APP_TAG} graph_branch_comparison
"

print_usage_n_exit() {
  echo -e ${__usage}
  WARN "Invalid subcommand or arguments -> ${@}"
  exit 0
}

not_a_git_repo() {
  local error="command called from a non git-root directory -> ${PWD}"
  local error_desc="kindly use this command from the root of a git initialized repo"
  echo "${error}\n${error_desc}" && WARN "${error}"
  exit 1
}

track_program_call() {
  DEBUG "graph requested -> ${1}"
}

test -d ${PWD}/.git || not_a_git_repo

if [ $# -eq 0 ]
  then
    all_insights
  else
    [[ $# -gt 2 ]] && print_usage_n_exit ${@}
    subcmd=$1
    shift
    subcmd_args=${@}
    case ${subcmd} in
        "graph_git_commit" )
          graph_git_commit ${subcmd_args}
          track_program_call ${subcmd};;
        "graph_git_trend" )
          graph_git_trend ${subcmd_args}
          track_program_call ${subcmd};;
        "graph_git_leaderboard" )
          graph_git_leaderboard ${subcmd_args}
          track_program_call ${subcmd};;
        "graph_git_hot_files" )
          graph_git_hot_files ${subcmd_args}
          track_program_call ${subcmd};;
        "graph_branch_comparison" )
          graph_branch_comparison ${subcmd_args}
          track_program_call ${subcmd};;
        "calendar_graph_git_log" )
          calendar_graph_git_log ${subcmd_args}
          track_program_call ${subcmd};;
        -h | --help | * )
          print_usage_n_exit ${subcmd};;
   esac
fi

# END
