##############################################
#    Helper Commands
##############################################
alias log='sudo journalctl -f'
alias reload='source $HOME/.bashrc 1>/dev/null'
alias clipboard='xsel'
alias lstree='ls -R | grep ":$" | sed -e "s/:$//" -e "s/[^-][^\/]*\//--/g" -e "s/^/ /" -e "s/-/|/"'
alias open="xdg-open"
alias tz="\
    printf 'Sao Paulo:\t ';\
    TZ='America/Sao_Paulo' date;\
    printf 'San Francisco:\t ';\
    TZ='America/Los_Angeles' date;\
    printf 'London:\t\t ';\
    TZ='Europe/London' date;\
    printf 'Porto:\t\t ';\
    TZ='Europe/Lisbon' date;\
    printf 'Prague:\t\t ';\
    TZ='Europe/Prague' date;\
"


##############################################
#    Removing useless files
##############################################

alias removepyc='find * -name "*.pyc" -delete'
alias removelog='find * -name "*.log" -delete'


##############################################
#    Git
##############################################

alias g='git'
alias ga='git add'
alias gb='git branch -a'
alias gd='git diff'
alias gu='git push origin HEAD'
alias gi='git commit'
alias gl='git log'
alias gco='git checkout'
alias gp='git pull -p --rebase'
alias gra='git rebase --abort'
alias grc='git rebase --continue'
alias gs='git status --untracked-files'
alias gt='git tag'
alias gpu='git pull -p --rebase && git submodule update'

# loading the completion for Git to use the complete functions
_completion_loader git
__git_complete g _git
__git_complete gco _git_checkout


##############################################
#    Better default commands powered by Rust
##############################################

alias ls="exa"
alias cat="bat"
alias find="fd"
alias grep="rg"


##############################################
#    Typos
##############################################

alias vmi='vim'
alias ivm='vim'
alias cim='vim'
alias bim='vim'
