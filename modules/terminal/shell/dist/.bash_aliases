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
__git_complete g _git  # loading the completion for Git


##############################################
#    Better default commands powered by Rust
##############################################

alias ls="exa"
alias cat="bat"


##############################################
#    Typos
##############################################

alias vmi='vim'
alias ivm='vim'
alias cim='vim'
alias bim='vim'
