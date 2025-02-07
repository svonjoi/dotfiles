#### reload the current zsh session
# The main advantage of exec zsh is that no rogue state is left
# after such a reload - e.g. env variables you’ve previously set
# that are no longer in your config. By the way, exec (like source)
# is just a Zsh built-in. Here is what the documentation has to 
# say about it
#
# exec zsh
# omz reload (alias for exec zsh)
#
#### reload config file
# source ~/.zshrc
# . ~/.zshrc
#
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
# location
# ~/.antigen folder where all the plugins are installed
#
# download from
# https://github.com/unixorn/awesome-zsh-plugins
# https://github.com/ohmyzsh/ohmyzsh/tree/master/plugins
#
# install plugin; прописать бандл и засорсить
# antigen bundle github-user/repo --branch=main
#
# uninstall plugin
#   just comment `antigen bundle` line & source .zshrc & restart shell (and zellij session..; just `zellij -ka` then restore session)
#
# todo: replace with https://github.com/mattmc3/antidote
# todo: https://github.com/MichaelAquilina/zsh-auto-notify

# Load Antigen
source "$HOME/antigen.zsh"

# Load the oh-my-zsh's library.
antigen use oh-my-zsh

# Bundles from the default repo (robbyrussell's oh-my-zsh).

# fzf-tab needs to be loaded after compinit, but before plugins which will wrap widgets, such as zsh-autosuggestions or fast-syntax-highlighting!!
# fzf-tab ALSO needs fzf installed, otherwise it cannot work!
# todo: docs https://github.com/Aloxaf/fzf-tab#usage
# antigen bundle Aloxaf/fzf-tab
antigen bundle zsh-interactive-cd

antigen bundle git-auto-fetch
antigen bundle command-not-found
antigen bundle zsh-users/zsh-syntax-highlighting
antigen bundle MichaelAquilina/zsh-auto-notify

# list the shortcuts that are currently available based on the plugins you have enabled.
# https://github.com/ohmyzsh/ohmyzsh/tree/master/plugins/aliases
antigen bundle aliases

# https://github.com/ohmyzsh/ohmyzsh/wiki/FAQ#how-do-i-reset-the-completion-cache
antigen bundle zsh-users/zsh-autosuggestions
ZSH_AUTOSUGGEST_STRATEGY=(history completion)
# history: ~/.zsh_history

# https://github.com/zsh-users/zsh-autosuggestions/issues/751#issuecomment-1774018197
autoload -Uz compinit && compinit

antigen bundle z

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

# znap source marlonrichert/zsh-autocomplete
# znap install bigH/git-fuzzy

#? +-----------------------+
#? |         zinit         |
#? +-----------------------+

# https://github.com/zdharma-continuum/zinit
# zinit ice as"program" pick"bin/git-fuzzy"
# zinit light bigH/git-fuzzy

#? +-----------------------+
#? |       morkefavn       |
#? +-----------------------+

# configpath: ~/.config/nvim
# datapath ~/.local/share/nvim
export EDITOR=nvim

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
# exa, lsd accepts the same parms
alias l='exa --all --group-directories-first'
alias ll='lsd -l --all --group-directories-first'
alias llt='exa --tree --group-directories-first'
alias alert='notify-send --urgency=low -i "$([ $? = 0 ] && echo terminal || echo error)" "$(history|tail -n1|sed -e '\''s/^\s*[0-9]\+\s*//;s/[;&|]\s*alert$//'\'')"'
alias man='batman'
alias dump='~/.config/scripts/dump_svonux/dump_svonux.sh --full'

alias v=openNvimWithConfigSelecion
alias nvim1='NVIM_APPNAME=nvim-kickstart nvim'
alias nvim2='NVIM_APPNAME=nvim-lazyvim nvim'
bindkey -s "^v" "openNvimWithConfigSelecion2\n"

# alias zsh-source-config=zshSourceConfigFile
# alias zsh-reload-session=zshReloadSession
alias r='exec zsh'

alias re='removeWsLayout'

export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion


#  TODO: GIT ALIAS
# https://github.com/ohmyzsh/ohmyzsh/tree/master/plugins/git
alias gst='git status'
alias gco='git checkout'
alias g='git'
alias ga='git add'
alias gc='git commit --verbose'
alias gca='git commit --verbose --all'
alias gcam='git commit --all --message'
alias gd='git diff'
alias gf='git fetch'
alias gfa='git fetch --all --tags --prune'
alias gl='git pull'
alias gp='git push'
alias gpd='git push --dry-run'
alias gpv='git push --verbose'
alias grm='git rm'
alias rmc='git rm --cached'

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

addText() {
  if [ -z "$1" ]; then
    echo "Usage: addText <text>"
    return 1
  fi

  # text_to_add="$1"
  # RBUFFER=${text_to_add}${RBUFFER}

  # https://gist.github.com/YumaInaura/2a1a915b848728b34eacf4e674ca61eb
  # $1 is inputted as console input buffer not as command result stdout
  print -z $1
}

# Add a # to the front of the command (so it becomes a comment)
copy_last_command () {
  history | tail -n 1 | sed "s/[[:digit:]]*  //" | sed "s/^#//" | xclip
}
zle -N copy_last_command
bindkey '^k' copy_last_command

if [[ -n $DISPLAY ]]; then
    copy_line_to_x_clipboard() {
        echo -n $BUFFER | xclip -selection clipboard
        zle reset-prompt
    }
    zle -N copy_line_to_x_clipboard
    bindkey '^y' copy_line_to_x_clipboard
fi

# yadm
function yc() {
    cd ~
    yadm enter lazygit
    cd -
}

function apply_wallpaper() {
    # nitrogen --restore
    /usr/bin/dwall -s bitday
}

# Allow Ranger to `cd` your current shell by exiting with capital Q
# https://github.com/ranger/ranger/issues/1554#issuecomment-2576451254
function ranger {
  local IFS=$'\t\n'
  local tempfile="$(mktemp -t tmp.XXXXXX)"
  local ranger_cmd=(
    command
    ranger
    # quitallcd добавил в ~.config/ranger/commands.py
    --cmd="map Q quitallcd $tempfile"
  )
  
  ${ranger_cmd[@]} "$@"
  local target_dir=$(cat -- "$tempfile" | tr -d ' ')
  local cwd=$(echo -n `pwd` | tr -d ' ')
  if [[ -f "$tempfile" ]] && [[ "$target_dir" != "" ]] && \
      [[ "$target_dir" != "$cwd" ]]; then
    cd -- "$target_dir"
  fi
  command rm -f -- "$tempfile" 2>/dev/null
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
# PATH="$HOME/dev/third/sioyek/build${PATH:+:${PATH}}"; export PATH;

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

function openNvimWithConfigSelecion() {
  # Assumes all configs exist in directories named ~/.config/nvim-*
  local config=$(fd --max-depth 1 --glob 'nvim-*' ~/.config | fzf --prompt="Neovim Configs > " --height=~50% --layout=reverse --border --exit-0)
 
  # If I exit fzf without selecting a config, don't open Neovim
  [[ -z $config ]] && echo "No config selected" && return
 
  set -x
  # Open Neovim with the selected config
  NVIM_APPNAME=$(basename $config) nvim $@
}

# https://gist.github.com/elijahmanor/b279553c0132bfad7eae23e34ceb593b
function openNvimWithConfigSelecion2() {
  set -x
  items=$(find $HOME/.config -maxdepth 2 -name "init.lua" -type f -execdir sh -c 'pwd | xargs basename' \;)
  selected=$(printf "%s\n" "${items[@]}" | FZF_DEFAULT_OPTS="${FZF_DEFAULT_OPTS-} --preview-window 'right:border-left:50%:<40(right:border-left:50%:hidden)' --preview 'lsd -l -A --tree --depth=1 --color=always --blocks=size,name ~/.config/{} | head -200'" fzf )
  if [[ -z $selected ]]; then
    return 0
  elif [[ $selected == "nvim" ]]; then
    selected="nvim-kickstart"
  fi
  echo "$@"
  ~/.config/scripts/helpers/nvim_runner.sh $selected
  # NVIM_APPNAME=$selected nvim "$@"
}


function zshSourceConfigFile() {
  addText "source ~/.zshrc"
}

function zshReloadSession() {
  addText "exec zsh"
}

function removeWsLayout() {
  ~/.config/scripts/i3_scripts/ws/remove_ws_layout.sh
}


FZF_ALIAS_OPTS=${FZF_ALIAS_OPTS:-"--preview-window up:3:hidden:wrap"}

function fzf_alias() {
    local selection
    # use sed with column to work around MacOS/BSD column not having a -l option
    if selection=$(alias |
                       sed 's/=/\t/' |
                       column -s '	' -t |
                       FZF_DEFAULT_OPTS="$FZF_DEFAULT_OPTS $FZF_ALIAS_OPTS" fzf --preview "echo {2..}" --query="$BUFFER" |
                       awk '{ print $1 }'); then
        BUFFER=$selection
        CURSOR=$#BUFFER
    fi
    zle redisplay
}

zle -N fzf_alias
# bindkey "^a" fzf_alias
# A-a
bindkey -M emacs '\ea' fzf_alias
bindkey -M vicmd '\ea' fzf_alias
bindkey -M viins '\ea' fzf_alias



# fzf shell integration
# TODO: много полезняшек
# https://junegunn.github.io/fzf/shell-integration/
source <(fzf --zsh)

# Preview file content using bat (https://github.com/sharkdp/bat)
export FZF_CTRL_T_OPTS="
  --walker-skip .git,node_modules,target
  --preview 'bat -n --color=always {}'
  --bind 'ctrl-/:change-preview-window(down|hidden|)'"


