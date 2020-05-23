########################################
# EXPORTING ENVIRONMENT VARIABLES
########################################

export PATH="$HOME/bin:$PATH"
export CDPATH=.:~:$HOME/repos:$HOME/go/src
export RIPGREP_CONFIG_PATH=$HOME/.ripgreprc

export HISTCONTROL=ignoredups  # don't put duplicate lines in the history. See bash(1) for more options
export HISTCONTROL=ignoreboth  # ... and ignore same sucessive entries.
export HISTFILESIZE=5000

export EDITOR=vim
export GEM_EDITOR=vim
export GIT_EDITOR=vim

export GITHUB_USER=pothix
export CODES=$HOME/repos

export GPG_TTY=$(/usr/bin/tty)

export LANG=en_US.UTF-8

# when building kernels from AUR
export MAKEFLAGS=-$(nproc)

if [ -f /bin/urxvt ]; then
    export TERM=rxvt
fi

########################################
# USING COMPLETION AND ALIAS
########################################
source $HOME/.bash_aliases

if [[ "$(command -v gh)" != "" ]]
then
    eval "$(gh completion -s bash)"
fi

########################################
# Random helpers
########################################

v (){
    local editor="vi"

    if [[ "$(command -v vim)" != "" ]]
    then
        editor="vim"
    fi

    if [[ "$(command -v nvim)" != "" ]]
    then
        editor="nvim"
    fi

    # Removing : from a file name and adding + to go to the especified line
    local file=$(echo $1 | sed -r 's/:([0-9]+).*/ +\1/')
    eval "$editor $file"
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


########################################
# Language specific paths
########################################

# asdf-vm
source /opt/asdf-vm/asdf.sh

# Rust
export PATH=$HOME/.cargo/bin:$PATH

# Golang
export PATH=$HOME/go/bin:$PATH

# Javascript / npm
export PATH=$HOME/.npm-global/bin:$PATH

# Start starship
eval "$(starship init bash)"
