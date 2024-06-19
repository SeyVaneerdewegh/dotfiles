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

# Antidote
## Source Antidote
[[ -f $HOMEBREW_PREFIX/opt/antidote/share/antidote/antidote.zsh ]] && source "$HOMEBREW_PREFIX/opt/antidote/share/antidote/antidote.zsh"

## Load Zsh plugins with Antidote
if type "antidote" > /dev/null; then
  antidote load
fi

# User config
## Source additional files
[[ -f $HOME/.config/zsh/aliases ]] && source "$HOME/.config/zsh/aliases"
[[ -f $HOME/.config/zsh/env ]] && source "$HOME/.config/zsh/env"
[[ -f $HOME/.config/projects/config ]] && source "$HOME/.config/projects/config"
[[ -f $HOME/.env ]] && source "$HOME/.env" || touch "$HOME/.env"

## Activate (available) plugins
if type "thefuck" > /dev/null; then
  eval "$(thefuck --alias)"
fi

if type "jira" > /dev/null; then
  eval "$(jira --completion-script-bash)"
fi

if type "starship" > /dev/null; then 
  eval "$(starship init zsh)"
fi

if type "mise" > /dev/null; then
  eval "$(mise activate zsh)"
fi
