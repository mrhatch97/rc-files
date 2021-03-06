#
# ~/.bash_profile
#

echo -e "Bash version ${RED}${BASH_VERSION%.*}${NC} at $(date +%Y-%m-%d:%H:%M:%S)"

[[ -f ~/.bashrc ]] && . ~/.bashrc

export EDITOR=vim
export BUILDS=~/build
export SOURCE=~/src
export PATH+=":/home/mhatch/bin"
