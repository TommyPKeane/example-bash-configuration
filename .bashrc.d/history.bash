# BASh History Configuration
#
# Reference:
# - https://www.gnu.org/software/bash/manual/html_node/Using-History-Interactively.html
# - https://tldp.org/LDP/Bash-Beginners-Guide/html/sect_03_02.html

shopt -s histappend

export HISTCONTROL="ignorespace:erasedups"
export HISTFILESIZE=100000000
export HISTSIZE=100000000
export HISTTIMEFORMAT="%F_%T_%z  "
export HISTIGNORE="ls:fg:bg:history"
export HISTORY_IGNORE="ls:fg:bg:history"
export PROMPT_COMMAND="history -a"

