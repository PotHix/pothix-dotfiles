##############################################
#    Helper Commands
##############################################
alias t='tail -f'

alias log='sudo journalctl -f'
alias reload='source $HOME/.bashrc 1>/dev/null'
alias clipboard='xsel'
alias lstree='ls -R | grep ":$" | sed -e "s/:$//" -e "s/[^-][^\/]*\//--/g" -e "s/^/ /" -e "s/-/|/"'
alias sshr="ssh -l root"
alias open="xdg-open"
alias xmod="xmodmap ~/.Xmodmap"
alias tz="\
    printf 'Sao Paulo:\t ';\
    TZ='America/Sao_Paulo' date;\
    printf 'San Francisco:\t ';\
    TZ='America/Los_Angeles' date;\
    printf 'London:\t\t ';\
    TZ='Europe/London' date;\
    printf 'Porto:\t\t ';\
    TZ='Europe/Lisbon' date;\
    printf 'Copenhagen:\t ';\
    TZ='Europe/Copenhagen' date;\
"


##############################################
#    Removing useless files
##############################################

alias removepyc='find * -name "*.pyc" -delete'
alias removelog='find * -name "*.log" -delete'


##############################################
#    Git
##############################################

alias ga='git add'
alias gb='git branch -a'
alias gd='git diff'
alias gh='git-push'
alias gha='git-push-all'
alias gi='git commit'
alias gl='git log'
alias gm='git-merge'
alias gco='git checkout'
alias gp='git pull -p --rebase'
alias gpa='git-pull-all'
alias gpt='git push --tags'
alias gra='git rebase --abort'
alias grc='git rebase --continue'
alias grm="git status | grep deleted | awk '{print \$3}' | xargs git rm"
alias gs='git status --untracked-files'
alias gst='git stash'
alias gstc='git stash clear'
alias gstp='git stash pop'
alias gt='git tag'
alias gut='git-update-tag | xargs git tag'


##############################################
#    Typos
##############################################

alias vmi='vim'
alias ivm='vim'
alias cim='vim'
alias bim='vim'
