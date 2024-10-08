setopt share_history

source ~/.local/opt/antigen/antigen.zsh

antigen use oh-my-zsh

antigen bundle git
# antigen bundle docker

antigen bundle zsh-users/zsh-completions
antigen bundle zsh-users/zsh-syntax-highlighting
ZSH_AUTOSUGGEST_USE_ASYNC=1
antigen bundle zsh-users/zsh-autosuggestions

antigen theme tamorim/naiz naiz

antigen apply

# source ~/.antigen/bundles/zsh-users/zsh-completions/zsh-completions.plugin.zsh
# source ~/.antigen/bundles/zsh-users/zsh-autosuggestions/zsh-autosuggestions.zsh
# source ~/.antigen/bundles/zsh-users/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh

# Local config
# Apply here. Applying in ~/.zshenv results in more entries in PATH
[ -f ~/.env.sh ] && source ~/.env.sh

# Helper functions
function join_by { local IFS="$1"; shift; echo "$*"; }

function git_diff() {
  git diff --no-ext-diff -w "$@" | vim -R -
}

function print_path() {
  tr ':' '\n' <<< "$PATH"
}

# Aliases
function mkdircd() {
    mkdir "$1" && cd "$1"
}

alias dotfiles='git --work-tree=$HOME --git-dir=$HOME/.dotfiles'
function dotfiles_enter() {
    export GIT_WORK_TREE="$HOME"
    export GIT_DIR="$HOME/.dotfiles"
}
function dotfiles_exit() {
    unset GIT_WORK_TREE
    unset GIT_DIR
}

alias git='LANG=en_US.UTF-8 git'
alias gitka='gitk --all'

alias brew86="arch -x86_64 /usr/local/bin/brew"
alias pyenv86="arch -x86_64 pyenv"

# On ArchLinux add hx alias for helix
if [ -f "/etc/arch-release" ]
then
   alias hx=helix
fi


# # If you come from bash you might have to change your $PATH.
# # export PATH=$HOME/bin:/usr/local/bin:$PATH
# 
# # Path to your oh-my-zsh installation.
# export ZSH=~/.oh-my-zsh
# 
# # Set name of the theme to load. Optionally, if you set this to "random"
# # it'll load a random theme each time that oh-my-zsh is loaded.
# # See https://github.com/robbyrussell/oh-my-zsh/wiki/Themes
# ZSH_THEME="robbyrussell"
# 
# # Uncomment the following line to use case-sensitive completion.
# # CASE_SENSITIVE="true"
# 
# # Uncomment the following line to use hyphen-insensitive completion. Case
# # sensitive completion must be off. _ and - will be interchangeable.
# # HYPHEN_INSENSITIVE="true"
# 
# # Uncomment the following line to disable bi-weekly auto-update checks.
# # DISABLE_AUTO_UPDATE="true"
# 
# # Uncomment the following line to change how often to auto-update (in days).
# # export UPDATE_ZSH_DAYS=13
# 
# # Uncomment the following line to disable colors in ls.
# # DISABLE_LS_COLORS="true"
# 
# # Uncomment the following line to disable auto-setting terminal title.
# # DISABLE_AUTO_TITLE="true"
# 
# # Uncomment the following line to enable command auto-correction.
# # ENABLE_CORRECTION="true"
# 
# # Uncomment the following line to display red dots whilst waiting for completion.
# # COMPLETION_WAITING_DOTS="true"
# 
# # Uncomment the following line if you want to disable marking untracked files
# # under VCS as dirty. This makes repository status check for large repositories
# # much, much faster.
# # DISABLE_UNTRACKED_FILES_DIRTY="true"
# 
# # Uncomment the following line if you want to change the command execution time
# # stamp shown in the history command output.
# # The optional three formats: "mm/dd/yyyy"|"dd.mm.yyyy"|"yyyy-mm-dd"
# # HIST_STAMPS="mm/dd/yyyy"
# 
# # Would you like to use another custom folder than $ZSH/custom?
# ZSH_CUSTOM=~/.oh-my-zsh-custom
# 
# # Which plugins would you like to load? (plugins can be found in ~/.oh-my-zsh/plugins/*)
# # Custom plugins may be added to ~/.oh-my-zsh/custom/plugins/
# # Example format: plugins=(rails git textmate ruby lighthouse)
# # Add wisely, as too many plugins slow down shell startup.
# plugins=(git zsh-autosuggestions)
# 
# source $ZSH/oh-my-zsh.sh
# 
# # User configuration
# 
# # export MANPATH="/usr/local/man:$MANPATH"
# 
# # You may need to manually set your language environment
# # export LANG=en_US.UTF-8
# 
# # Preferred editor for local and remote sessions
# # if [[ -n $SSH_CONNECTION ]]; then
# #   export EDITOR='vim'
# # else
# #   export EDITOR='mvim'
# # fi
# 
# # Compilation flags
# # export ARCHFLAGS="-arch x86_64"
# 
# # ssh
# # export SSH_KEY_PATH="~/.ssh/rsa_id"
# 
# # Set personal aliases, overriding those provided by oh-my-zsh libs,
# # plugins, and themes. Aliases can be placed here, though oh-my-zsh
# # users are encouraged to define aliases within the ZSH_CUSTOM folder.
# # For a full list of active aliases, run `alias`.
# #
# # Example aliases
# # alias zshconfig="mate ~/.zshrc"
# # alias ohmyzsh="mate ~/.oh-my-zsh"
# 
# # setopt CHECK_JOBS
# 
# [ -f ~/.env.sh ] && source ~/.env.sh
# 
# alias dotfiles='git --work-tree=$HOME --git-dir=$HOME/.dotfiles'
# 
# alias lsl='ls -al'
# 
# alias a='fasd -a'        # any
# alias s='fasd -si'       # show / search / select
# alias d='fasd -d'        # directory
# alias f='fasd -f'        # file
# alias sd='fasd -sid'     # interactive directory selection
# alias sf='fasd -sif'     # interactive file selection
# alias z='fasd_cd -d'     # cd, same functionality as j in autojump
# alias zz='fasd_cd -d -i' # cd with interactive selection
# 
# alias v='f -e vim' # quick opening files with vim
# alias m='f -e mplayer' # quick opening files with mplayer
# alias o='a -e xdg-open' # quick opening files with xdg-open
# 
# bindkey '^X^A' fasd-complete    # C-x C-a to do fasd-complete (fils and directories)
# bindkey '^X^F' fasd-complete-f  # C-x C-f to do fasd-complete-f (only files)
# bindkey '^X^D' fasd-complete-d  # C-x C-d to do fasd-complete-d (only directories)
# 
