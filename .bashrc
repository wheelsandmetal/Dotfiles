GREEN="\[$(tput setaf 2)\]"
RESET="\[$(tput sgr0)\]"
export PS1="${GREEN}\A \h \w $ ${RESET}"
bind "TAB:menu-complete"
bind "set show-all-if-ambiguous on"
source ~/.aliases
set bell-style visible
export CLASSPATH=.:/Users/Jakob/
