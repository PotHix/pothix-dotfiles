set -o vi    # The real bash must use Vi
bind -m vi-insert "\C-l":clear-screen # clear with ctrl+l for vi mode

###############################################################################################
# EXPORTING ENVIRONMENT VARIABLES
###############################################################################################

export pwshome="$HOME/.dotbin/shssword/bin"

export PATH="$HOME/bin:$HOME/$pwdhome:$PATH"
export CDPATH=.:~:$HOME/repos

export HISTCONTROL=ignoredups:ignoreboth:erasedups
export HISTFILE=$HOME/.bash_history
export HISTFILESIZE=10000
export HISTSIZE=7500

export EDITOR=vim
export GEM_EDITOR=vim

export GITHUB_USER=PotHix
export CODES=$HOME/repos

export GREP_OPTIONS="--color=auto"
export GREP_COLOR="4;33"

export GPG_TTY=$(/usr/bin/tty)

if [ -f /bin/urxvt ]; then
	export TERM=rxvt
fi


###############################################################################################
# USING COMPLETION AND ALIAS
###############################################################################################
source $HOME/.git_completion.sh
source $HOME/.gem_completion.sh
source $HOME/.bash_aliases


###############################################################################################
# GIT THINGS
###############################################################################################

# github repository cloning
# usage:
#    github username repository ~> will clone someone else's
github() {
	if [ $# = 1 ]; then
		git clone git@github.com:$GITHUB_USER/$1.git $CODES/$1;
		builtin cd $1 && ls;
	elif [ $# = 2 ]; then
		git clone git://github.com/$1/$2.git $CODES/$2;
		builtin cd $2 && ls;
	else
		echo "Usage:";
		echo "    github <repo>        ~> will clone $GITHUB_USER's <repo> to $CODES";
		echo "    github <user> <repo> ~> will clone <user>'s <repo> to $CODES";
	fi
}

git-prompt () {
	local        BLUE="\[\033[0;34m\]"
	local         RED="\[\033[0;31m\]"
	local   LIGHT_RED="\[\033[1;31m\]"
	local       GREEN="\[\033[0;32m\]"
	local LIGHT_GREEN="\[\033[1;32m\]"
	local       WHITE="\[\033[1;37m\]"
	local    NO_COLOR="\[\e[0m\]"
	local        GRAY="\[\033[1;30m\]"
	local  LIGHT_GRAY="\[\033[0;37m\]"
	local      YELLOW="\[\033[0;33m\]"

	local BRANCH=`git branch 2> /dev/null | grep \* | sed 's/* //'`
	local STATUS=`git status 2>/dev/null`
	local HOSTNAME=`hostname | sed 's/^./\U&/g'`
	local PROMPT_COLOR=$GREEN
	local STATE=" "
	local BEHIND="# Your branch is behind"
	local AHEAD="# Your branch is ahead"
	local UNTRACKED="# Untracked files"
	local DIVERGED="have diverged"
	local CHANGED="# Changed but not updated"
	local TO_BE_COMMITED="# Changes to be committed"

	if [ "$BRANCH" != "" ]; then
		if [[ "$STATUS" =~ "$DIVERGED" ]]; then
			PROMPT_COLOR=$RED
			STATE="${STATE}${RED}↕${NO_COLOR}"
		elif [[ "$STATUS" =~ "$BEHIND" ]]; then
			PROMPT_COLOR=$RED
			STATE="${STATE}${RED}↓${NO_COLOR}"
		elif [[ "$STATUS" =~ "$AHEAD" ]]; then
			PROMPT_COLOR=$RED
			STATE="${STATE}${RED}↑${NO_COLOR}"
		elif [[ "$STATUS" =~ "$CHANGED" ]]; then
			PROMPT_COLOR=$RED
			STATE=""
		elif [[ "$STATUS" =~ "$TO_BE_COMMITED" ]]; then
			PROMPT_COLOR=$RED
			STATE=""
		else
			PROMPT_COLOR=$GREEN
			STATE=""
		fi

		if [[ "$STATUS" =~ "$UNTRACKED" ]]; then
			STATE="${STATE}${YELLOW}*${NO_COLOR}"
		fi

		PS1="$WHITE[${HOSTNAME} \W]${NO_COLOR}(${PROMPT_COLOR}${BRANCH}${NO_COLOR}${STATE}) " # (${YELLOW}$(rvm_version)${NO_COLOR})\n$ "
	else
		PS1="$WHITE[${HOSTNAME} \W]${NO_COLOR} " # (${YELLOW}$(rvm_version)${NO_COLOR})\n\$ "
	fi
}

PROMPT_COMMAND=git-prompt

git-merge (){
	local BRANCH=`git branch 2> /dev/null | grep \* | sed 's/* //'`
	if [ $# = 1 ]; then
		git co $1 && git pull && git co $BRANCH && git merge $1 && git push origin $BRANCH
	else
		echo "Usage:";
		echo "    git-merge <branch_with_changes>";
	fi
}

# Pair programming utils for Git
git-unpair (){
	if [[ "$1" == "" ]]; then
		`git config --remove-section user`
	fi
}

git-pair (){
	local default_name="PotHix"
	local default_email="pothix@pothix.com"

	if [ "$1" != "" ]; then
		git-unpair
		`git config --add user.name "$default_name & $1"`
		`git config --add user.email "$default_email"`
	fi
}
git-push (){
	git push origin `git branch 2> /dev/null | grep \* | sed 's/* //'`
}

git-push-all (){
	local remotes=`git remote`
	local branch=`git branch 2> /dev/null | grep \* | sed 's/* //'`
	for remote in $remotes; do
		git push $remote $branch
	done
}

git-pull-all (){
	local remotes=`git remote`
	local branch=`git branch 2> /dev/null | grep \* | sed 's/* //'`
	for remote in $remotes; do
		git pull --rebase $remote $branch
	done
}

git-update-testing (){
	local lasttagprefix=$(git tags | grep testing | tail -n1 | cut -d. -f1-2)
	local nextnumber=$(expr $(git tags | grep testing | tail -n1 | cut -d. -f3) + 1)
	echo $lasttagprefix.$nextnumber
}

git-update-stable (){
	local lasttagprefix=$(git tags | grep stable | tail -n1 | cut -d. -f1-2)
	local nextnumber=$(expr $(git tags | grep -v unstable | grep stable | tail -n1 | cut -d. -f3) + 1)
	echo $lasttagprefix.$nextnumber
}


###############################################################################################
# Random helpers
###############################################################################################

v (){
	# Removing : from a file name and adding + to go to the especified line
	local file=$(echo $1 | sed -r 's/:([0-9]+).*/ +\1/')
	vim $file
}

rgrep (){
	grep $1 {app,spec,lib,db,config}/* -Rin
}

goodpractices (){
	local extensions_regex=".*\.\(py\|j\|c\|rb\|js\|php\)$"

	# Removing trailing spaces
	find * -type f -regex $extensions_regex | xargs sed -i 's/\s\+$//g'

	# Adding a newline to the end of the file if needed
	for i in `find * -type f -regex $extensions_regex`; do
		if [ "`tail -c 1 $i`" != "" ]; then echo >> $i; fi

		for k in $@; do
			git checkout $k
		done
	done
}

iconver (){
	for i in `find . | egrep "\.(css|html|js)"`; do iconv -f iso-8859-1 -t utf8 $i > $i.utf; done
	for i in `find . | grep utf`; do cp $i ${i%%.utf}; rm $i; done
}

###############################################################################################
# Using RVM
###############################################################################################
[[ -s "$HOME/.pythonbrew/etc/bashrc" ]] && source "$HOME/.pythonbrew/etc/bashrc"
PATH=$HOME/.rvm/bin:$PATH # Add RVM to PATH for scripting
export PATH="$HOME/.rbenv/bin:$PATH"
eval "$(rbenv init -)"
