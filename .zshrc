# If you come from bash you might have to change your $PATH.
# export PATH=$HOME/bin:/usr/local/bin:$PATH

# Path to your oh-my-zsh installation.
export ZSH="$HOME/.oh-my-zsh"


# Set name of the theme to load --- if set to "random", it will
# load a random theme each time oh-my-zsh is loaded, in which case,
# to know which specific one was loaded, run: echo $RANDOM_THEME
# See https://github.com/ohmyzsh/ohmyzsh/wiki/Themes

# intika --> https://github.com/ohmyzsh/ohmyzsh/wiki/External-themes#intika-theme
# ZSH_THEME="robbyrussell"
ZSH_THEME="garyblessington"

# todo: https://github.com/liquidprompt/liquidprompt
# antigen bundle liquidprompt/liquidprompt

# Set list of themes to pick from when loading at random
# Setting this variable when ZSH_THEME=random will cause zsh to load
# a theme from this variable instead of looking in $ZSH/themes/
# If set to an empty array, this variable will have no effect.
# ZSH_THEME_RANDOM_CANDIDATES=( "robbyrussell" "agnoster" )

# Uncomment the following line to use case-sensitive completion.
# CASE_SENSITIVE="true"

# Uncomment the following line to use hyphen-insensitive completion.
# Case-sensitive completion must be off. _ and - will be interchangeable.
# HYPHEN_INSENSITIVE="true"

# Uncomment one of the following lines to change the auto-update behavior
# zstyle ':omz:update' mode disabled  # disable automatic updates
# zstyle ':omz:update' mode auto      # update automatically without asking
zstyle ':omz:update' mode reminder  # just remind me to update when it's time

# Uncomment the following line to change how often to auto-update (in days).
zstyle ':omz:update' frequency 13

# Uncomment the following line if pasting URLs and other text is messed up.
# DISABLE_MAGIC_FUNCTIONS="true"

# Uncomment the following line to disable colors in ls.
# DISABLE_LS_COLORS="true"

# Uncomment the following line to disable auto-setting terminal title.
# DISABLE_AUTO_TITLE="true"

# Uncomment the following line to enable command auto-correction.
# ENABLE_CORRECTION="true"

# Uncomment the following line to display red dots whilst waiting for completion.
# You can also set it to another string to have that shown instead of the default red dots.
# e.g. COMPLETION_WAITING_DOTS="%F{yellow}waiting...%f"
# Caution: this setting can cause issues with multiline prompts in zsh < 5.7.1 (see #5765)
# COMPLETION_WAITING_DOTS="true"

# Uncomment the following line if you want to disable marking untracked files
# under VCS as dirty. This makes repository status check for large repositories
# much, much faster.
# DISABLE_UNTRACKED_FILES_DIRTY="true"

# Uncomment the following line if you want to change the command execution time
# stamp shown in the history command output.
# You can set one of the optional three formats:
# "mm/dd/yyyy"|"dd.mm.yyyy"|"yyyy-mm-dd"
# or set a custom format using the strftime function format specifications,
# see 'man strftime' for details.
# HIST_STAMPS="mm/dd/yyyy"

# Would you like to use another custom folder than $ZSH/custom?
# ZSH_CUSTOM=/path/to/new-custom-folder

# Which plugins would you like to load?
# Standard plugins can be found in $ZSH/plugins/
# Custom plugins may be added to $ZSH_CUSTOM/plugins/
# Example format: plugins=(rails git textmate ruby lighthouse)
# Add wisely, as too many plugins slow down shell startup.
plugins=(
    git
    git-auto-fetch
)

source $ZSH/oh-my-zsh.sh

# User configuration

# export MANPATH="/usr/local/man:$MANPATH"

# You may need to manually set your language environment
export LANG=en_US.UTF-8
export LC_ALL=en_US.UTF-8

# Preferred editor for local and remote sessions
# if [[ -n $SSH_CONNECTION ]]; then
#   export EDITOR='vim'
# else
#   export EDITOR='mvim'
# fi

# Compilation flags
# export ARCHFLAGS="-arch x86_64"

# Set personal aliases, overriding those provided by oh-my-zsh libs,
# plugins, and themes. Aliases can be placed here, though oh-my-zsh
# users are encouraged to define aliases within the ZSH_CUSTOM folder.
# For a full list of active aliases, run `alias`.
#
# Example aliases
# alias zshconfig="mate ~/.zshrc"
# alias ohmyzsh="mate ~/.oh-my-zsh"


#? +-----------------------+
#? |        Antigen        |
#? +-----------------------+
# plugins: https://github.com/unixorn/awesome-zsh-plugins
# antigen bundle github-user/repo --branch=main
# ~/.antigen folder where all the plugins are installed
# uninstall plugin: just comment `antigen bundle` line & source .zshrc & restart shell (and zellij session..; just `zellij -ka` then restore session)

# todo: replace with https://github.com/mattmc3/antidote
# todo: https://github.com/MichaelAquilina/zsh-auto-notify

# Load Antigen
source "$HOME/antigen.zsh"

# Load the oh-my-zsh's library.
antigen use oh-my-zsh

# Bundles from the default repo (robbyrussell's oh-my-zsh).

# https://github.com/ohmyzsh/ohmyzsh/tree/master/plugins/git
antigen bundle git

# fzf-tab needs to be loaded after compinit, but before plugins which will wrap widgets, such as zsh-autosuggestions or fast-syntax-highlighting!!
# fzf-tab ALSO needs fzf installed, otherwise it cannot work!
# todo: docs https://github.com/Aloxaf/fzf-tab#usage
antigen bundle Aloxaf/fzf-tab

antigen bundle heroku
antigen bundle pip
antigen bundle lein
antigen bundle command-not-found
antigen bundle djui/alias-tips
antigen bundle zsh-users/zsh-syntax-highlighting
antigen bundle MichaelAquilina/zsh-auto-notify

# history: ~/.zsh_history
antigen bundle zsh-users/zsh-autosuggestions

# https://github.com/zsh-users/zsh-autosuggestions/issues/751#issuecomment-1774018197
autoload -Uz compinit && compinit

# differences with https://github.com/ajeetdsouza/zoxide ???
antigen bundle z

# Tell Antigen that you're done.
antigen apply

# colorls
# source $(dirname $(gem which colorls))/tab_complete.sh

#? +-----------------------+
#? |        znap!          |
#? +-----------------------+

# Download Znap, if it's not there yet.
[[ -r ~/Repos/znap/znap.zsh ]] ||
    git clone --depth 1 -- \
        https://github.com/marlonrichert/zsh-snap.git ~/Repos/znap
source ~/Repos/znap/znap.zsh # Start Znap

# +-----------------------+
# this plugin replaces the fzf-tab functionallity in a worst way
# features i use https://github.com/marlonrichert/zsh-autocomplete#other-features
# - `ctrl+r` real-time history search listing multiple results
# - `up` las history items, 
# todo: docs https://github.com/marlonrichert/zsh-autocomplete#other-features

# real-time type-ahead autocompletion to Zsh. Find as you type, then press `Tab` to insert the top completion or `down` to select another completion
# instalando este plugin con antigen da error

# https://github.com/marlonrichert/zsh-autocomplete/discussions/604
# zstyle ':autocomplete:key-bindings' enabled no

### [fix] fzf-tab & zsh-autocomplete compatibility check
### https://github.com/Aloxaf/fzf-tab/issues/198
my-fzf-tab() {
  functions[compadd]=$functions[-ftb-compadd]
  zle fzf-tab-complete
}
zle -N my-fzf-tab
bindkey "^I" my-fzf-tab

znap source marlonrichert/zsh-autocomplete

#? +-----------------------+
#? |         zinit         |
#? +-----------------------+

# https://github.com/zdharma-continuum/zinit

#? +-----------------------+
#? |        svonjoi        |
#? +-----------------------+

export EDITOR=/usr/bin/vim
export KLOUD="/mnt/gdrive_loadmaks/"
export POLYBAR_SCRIPTS="$HOME/bin/polybar_scripts"

# enable color support of ls and also add handy aliases
if [ -x /usr/bin/dircolors ]; then
  test -r ~/.dircolors && eval "$(dircolors -b ~/.dircolors)" || eval "$(dircolors -b)"
  alias ls='ls --color=auto'
  #alias dir='dir --color=auto'
  #alias vdir='vdir --color=auto'

  alias grep='grep --color=auto'
  alias fgrep='fgrep --color=auto'
  alias egrep='egrep --color=auto'
fi

# colored GCC warnings and errors
#export GCC_COLORS='error=01;31:warning=01;35:note=01;36:caret=01;32:locus=01:quote=01'

# some more ls aliases
alias l='exa --all --group-directories-first'
alias ll='exa -l --all --group-directories-first'
alias llt='exa --tree --group-directories-first'
alias alert='notify-send --urgency=low -i "$([ $? = 0 ] && echo terminal || echo error)" "$(history|tail -n1|sed -e '\''s/^\s*[0-9]\+\s*//;s/[;&|]\s*alert$//'\'')"'
alias man='batman'


# https://stackoverflow.com/a/39839346/16719196

# shopt -s cdable_vars
# export ddev=$HOME/Documents/dev/
# export dsanjuan2=$HOME/Documents/dev/sanjuan2/
# export dgdrive_loadmaks=$HOME/Documents/gdrive_loadmaks/
# export dgdrive_svonjoi=$HOME/Documents/gdrive_svonjoi/
# export dpkm=/media/svonjoi/Data/private/pkm_vampir/

export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion



# he instalado esto pero tira de su propia bdd asi que he vuelto con zsh-z para
# no volver a completar la bdd, xq tampoco he visto ninguna mejora
# estos son dirs donde cayeron los archivos que se instalaron con el script q viene en el github
# Installed zoxide to /home/svonjoi/.local/bin
# Installed manpages to /home/svonjoi/.local/share/man
# add zoxide to zsh shell
# eval "$(zoxide init zsh)"

# +-----------------------+
# |       FUNCTIONS       |
# +-----------------------+

@c(){
  xargs echo -n | xclip -selection clipboard
}

# https://www.cyberciti.biz/faq/how-do-i-copy-a-file-to-the-clipboard-in-linux/
# multiline
@c2() {
  xclip -sel clip
}

yankpath () {
  realpath $1 | yank
}

# +-----------------------+
# |         $PATH         |
# +-----------------------+

# the directory must have permissions: chmod -R 755 ~/bin
if [ -d $HOME/.config/scripts ]; then
  PATH=$PATH:$HOME/bin
fi

# export all ~/bin subdirectories
for dir in $HOME/.config/scripts/*/ ; do
  export PATH="$PATH:$dir"
done


# sioyek
PATH="$HOME/dev/third/sioyek/build${PATH:+:${PATH}}"; export PATH;

# export PATH="$PATH:$HOME/.config/i3/scripts/"

# kitty fix ssh issue
# https://sw.kovidgoyal.net/kitty/faq/#i-get-errors-about-the-terminal-being-unknown-or-opening-the-terminal-failing-or-functional-keys-like-arrow-keys-don-t-work
# [ "$TERM" = "xterm-kitty" ] && alias ssh="kitty +kitten ssh"
#
# UPD. este puto fix crea nuevo problema - en zellij se queda colgao al conectarse
# https://github.com/kovidgoyal/kitty/issues/5900
#
# UPD. Надо китти на сервак ставить или терминфо как минимум (не пробовал)
# UPD. в mosh проблем нету

PATH="/home/svonjoi/perl5/bin${PATH:+:${PATH}}"; export PATH;
PERL5LIB="/home/svonjoi/perl5/lib/perl5${PERL5LIB:+:${PERL5LIB}}"; export PERL5LIB;
PERL_LOCAL_LIB_ROOT="/home/svonjoi/perl5${PERL_LOCAL_LIB_ROOT:+:${PERL_LOCAL_LIB_ROOT}}"; export PERL_LOCAL_LIB_ROOT;
PERL_MB_OPT="--install_base \"/home/svonjoi/perl5\""; export PERL_MB_OPT;
PERL_MM_OPT="INSTALL_BASE=/home/svonjoi/perl5"; export PERL_MM_OPT;


# Fix zsh autosuggestions keybind for arrow keys
# zle-line-init() {}
# bindkey '\e[A' history-beginning-search-backward
# bindkey '\e[B' history-beginning-search-forward
# bindkey "^[[A" history-beginning-search-backward
# bindkey "^[[B" history-beginning-search-forward

# colored man pager with bat, using bat configured theme
# just install bat-extras and add this customization
# https://github.com/eth-p/bat-extras/blob/master/doc/batman.md#changing-the-theme
# https://stackoverflow.com/questions/42822661/oh-my-zsh-git-maximum-nested-function-level-reached
function batman() {
    BAT_THEME="Solarized (dark)" command batman "$@"
    return $?
}
