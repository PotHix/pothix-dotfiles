##############################################
#    Helper Commands
##############################################
alias t='tail -f'

alias make="make -j2"
alias maked="make -f dev.makefile"
alias reload='source $HOME/.bashrc 1>/dev/null'
alias clipboard='xsel'
alias psgrep="ps aux | grep"
alias sshadd="ssh-add ~/.ssh/id_rsa"
alias sshr="ssh -l root"
alias emc="emacs -nw"
alias open="xdg-open"


##############################################
#    Ruby / Rails
##############################################
alias r='rails'
alias bi='bundle install --binstubs .gembin'


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
alias go='git checkout'
alias gp='git pull --rebase'
alias gpa='git-pull-all'
alias grc='git rebase --continue'
alias gra='git rebase --abort'
alias gs='git status --untracked-files'
alias gst='git stash'
alias gstp='git stash pop'
alias gstc='git stash clear'
alias gpt='git push --tags'
alias gt='git tag'
alias gut='git-update-testing | xargs git tag'


##############################################
#    Typos
##############################################

alias vmi='vim'
alias ivm='vim'
alias cim='vim'
alias bim='vim'
