##############################################
#    Helper Commands
##############################################
alias t='tail -f'

alias make="make -j2"
alias reload='source $HOME/.bashrc 1>/dev/null'
alias clipboard='xsel --clipboard --input'
alias psgrep="ps aux | grep"
alias sshadd="ssh-add ~/.ssh/id_rsa"
alias sshr="ssh -l root"
alias emc="emacs -nw"

if [ -d /Applications ]; then
    alias vim="/Applications/Vim.app/Contents/MacOS/Vim"
    alias ls="ls -G"
else
    alias ls="ls --color"
fi


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
#    Special Alias for particular projects
##############################################

alias update-conf="cat config/nephelae.yml.example | sed 's/hosts.conf/pothix.conf/g' | sed 's/prefix_name: \"cloud\"/prefix_name: \"pothix\"/g' > config/nephelae.yml"

# Openstack Quantum
alias quantum-pep8="find * -name '*.py' | xargs pep8 --repeat --show-source"
alias quantum-tests="export PYTHONPATH=../python-quantumclient; echo n | ./run_tests.sh && python ./quantum/plugins/blanka/run_tests.py"


##############################################
#    Git
##############################################

alias ga='git add'
alias gb='git branch -a'
alias gd='git diff'
alias gh='git-push'
alias gi='git commit'
alias gl='git log'
alias gm='git-merge'
alias go='git checkout'
alias gp='git pull --rebase'
alias grc='git rebase --continue'
alias gra='git rebase --abort'
alias gs='git status --untracked-files'
alias gst='git stash'
alias gstp='git stash pop'
alias gstc='git stash clear'
alias gt='git tag'
alias gut='git-update-testing | xargs git tag'


##############################################
#    Typos
##############################################

alias vmi='vim'
alias ivm='vim'
alias cim='vim'
alias bim='vim'
