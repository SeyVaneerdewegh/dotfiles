# Base Zsh config
## Options
setopt autocd 		# Turns on easy-folder navigatgion: if commmand is folder, make it current folder.
# setopt extendedglob 	# Turns on more globbing options, see https://zsh.sourceforge.io/Intro/intro_2.html.
setopt correct		# Turns on spelling correction for commands.
setopt correctall	# Turns on spelling correction for all arguments.
## History
HIST_STAMPS="dd.mm.yyyy"
HISTSIZE=5000
HISTFILE=~/.zsh_history
SAVEHIST=$HISTSIZE
HISTDUP=erase
setopt appendhistory
setopt sharehistory
setopt hist_ignore_space
setopt hist_ignore_all_dups
setopt hist_save_no_dups
setopt hist_ignore_dups
setopt hist_find_no_dups
## Include homebrew in path
if [[ -f "/opt/homebrew/bin/brew" ]] then
  # If you're using macOS, you'll want this enabled
  eval "$(/opt/homebrew/bin/brew shellenv)"
fi

# Plugin manager setup - zinit
## Set the directory we want to store zinit and plugins
ZINIT_HOME="${XDG_DATA_HOME:-${HOME}/.local/share}/zinit/zinit.git"
## Download Zinit, if it's not there yet
if [ ! -d "$ZINIT_HOME" ]; then
   mkdir -p "$(dirname $ZINIT_HOME)"
   git clone https://github.com/zdharma-continuum/zinit.git "$ZINIT_HOME"
fi
## Source/Load zinit
source "${ZINIT_HOME}/zinit.zsh"

# Plugins & Snippets
## Add in zsh plugins
zinit light zsh-users/zsh-syntax-highlighting
zinit light zsh-users/zsh-completions
zinit light zsh-users/zsh-autosuggestions
zinit light Aloxaf/fzf-tab
## Add in snippets
zinit snippet OMZP::git
zinit snippet OMZP::sudo
zinit snippet OMZP::aws
zinit snippet OMZP::kubectl
zinit snippet OMZP::kubectx
zinit snippet OMZP::command-not-found
## Load completions
autoload -Uz compinit && compinit

# Plugin configuration
## Keybindings
bindkey -e
bindkey '^p' history-search-backward
bindkey '^n' history-search-forward
bindkey '^[w' kill-region
## Completion styling
zstyle ':completion:*' matcher-list 'm:{a-z}={A-Za-z}'
zstyle ':completion:*' list-colors "${(s.:.)LS_COLORS}"
zstyle ':completion:*' menu no
## FZF
if type "fzf" > /dev/null; then
  eval "$(fzf --zsh)"
  zstyle ':fzf-tab:complete:*' fzf-preview 'ls --color $realpath'
  zstyle ':fzf-tab:complete:__zoxide_z:*' fzf-preview 'ls --color $realpath'
fi
## zouide - easy directory navigation
type "zoxide" > /dev/null && eval "$(zoxide init --cmd cd zsh)"
## Activate (available) plugins
type "thefuck" > /dev/null && eval "$(thefuck --alias)"
type "jira" > /dev/null && eval "$(jira --completion-script-bash)"
type "starship" > /dev/null && eval "$(starship init zsh)"
type "mise" > /dev/null && eval "$(mise activate zsh)"

# User config
## Source additional files
[[ -f $HOME/.config/zsh/aliases ]] && source "$HOME/.config/zsh/aliases"
[[ -f $HOME/.config/zsh/env ]] && source "$HOME/.config/zsh/env"
[[ -f $HOME/.config/projects/config ]] && source "$HOME/.config/projects/config"
[[ -f $HOME/.env ]] && source "$HOME/.env" || touch "$HOME/.env"
