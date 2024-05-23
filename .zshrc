# History
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

# Source Antidote
source "$HOMEBREW_PREFIX/opt/antidote/share/antidote/antidote.zsh"

# Load Zsh plugins with Antidote
antidote load

# Source additional files last to override any plugins
[[ -f $HOME/.config/zsh/aliases ]] && source "$HOME/.config/zsh/aliases"
[[ -f $HOME/.config/zsh/env ]] && source "$HOME/.config/zsh/env"

# Activate plugins
eval "$(thefuck --alias)"
eval "$(jira --completion-script-bash)"
eval "$(starship init zsh)"
eval "$(mise activate zsh)"
