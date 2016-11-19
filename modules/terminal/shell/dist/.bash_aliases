##############################################
#    Helper Commands
##############################################
alias t='tail -f'

alias maked="make -f dev.makefile"
alias reload='source $HOME/.bashrc 1>/dev/null'
alias clipboard='xsel'
alias psgrep="ps aux | grep"
alias lstree='ls -R | grep ":$" | sed -e "s/:$//" -e "s/[^-][^\/]*\//--/g" -e "s/^/ /" -e "s/-/|/"'
alias sshr="ssh -l root"
alias open="xdg-open"
alias xmod="xmodmap ~/.Xmodmap"


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
