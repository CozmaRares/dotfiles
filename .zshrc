if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

export EDITOR=nvim
export ZSH="$HOME/.oh-my-zsh"

ZSH_THEME="powerlevel10k/powerlevel10k"

HYPHEN_INSENSITIVE="true"

# History
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

plugins=(
  aliases
  command-not-found
  colored-man-pages
  dirhistory
  git
  npm
  sudo
  zsh-autosuggestions
  zsh-syntax-highlighting
  fzf-tab
)

# package includes

source $ZSH/oh-my-zsh.sh
source $HOME/.cargo/env

export TX_ROOT="$HOME/.tx"
source "$TX_ROOT/_tx"
source "$HOME/.gud/_gud"

export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion

[ -s "/home/cozma/.bun/_bun" ] && source "/home/cozma/.bun/_bun"
export BUN_INSTALL="$HOME/.bun"
export PATH="$BUN_INSTALL/bin:$PATH"

export PNPM_HOME="/home/raru/.local/share/pnpm"
case ":$PATH:" in
  *":$PNPM_HOME:"*) ;;
  *) export PATH="$PNPM_HOME:$PATH" ;;
esac

eval "$(zoxide init zsh)"
eval "$(fzf --zsh)"

# zstyle ':omz:update' mode disabled  # disable automatic updates
zstyle ':omz:update' mode auto      # update automatically without asking
# zstyle ':omz:update' mode reminder  # just remind me to update when it's time

zstyle ':omz:update' frequency 7

# Uncomment the following line if pasting URLs and other text is messed up.
# DISABLE_MAGIC_FUNCTIONS="true"

# disable sort when completing `git checkout`
zstyle ':completion:*:git-checkout:*' sort false
# set descriptions format to enable group support
# NOTE: don't use escape sequences here, fzf-tab will ignore them
zstyle ':completion:*:descriptions' format '[%d]'
# set list-colors to enable filename colorizing
zstyle ':completion:*' list-colors ${(s.:.)LS_COLORS}
# force zsh not to show completion menu, which allows fzf-tab to capture the unambiguous prefix
zstyle ':completion:*' menu no
# preview directory's content with eza when completing cd & zoxide
zstyle ':fzf-tab:complete:cd:*' fzf-preview 'eza -1 --color=always $realpath'
zstyle ':fzf-tab:complete:z:*' fzf-preview 'eza -1 --color=always $realpath'
# switch group using `<` and `>`
zstyle ':fzf-tab:*' switch-group '<' '>'

alias rm='rm -I --preserve-root'
alias chmod='chmod --preserve-root'
alias chown='chown --preserve-root'
alias chgrp='chgrp --preserve-root'

alias ls='eza --group-directories-first'
alias tree='eza --tree'

alias rat='bat --paging=never --style=plain'

alias cls='clear'

alias pnpmi='pnpm install'
alias pnpmd='pnpm install -D'

alias gcam="git commit --amend"
alias gcne="git commit --amend --no-edit"
alias ggc="gud commit"
alias gcl="git clone --depth=1 --recurse-submodules"

alias vim=nvim
alias vi=nvim
alias v=nvim

alias password="pass show -c"

alias wifi='~/.config/scripts/rofi-wifi-menu.sh'
alias bluetooth='~/.config/scripts/rofi-bluetooth'
alias pwrmgr='~/.config/scripts/rofi-power-manager.sh'
alias nightmode="~/.config/scripts/awesome/nightmode"

alias clip="xclip -selection clipboard"
alias ff="fastfetch | lolcat -r"

alias dcu="docker compose up"
alias dcd="docker compose down"

alias open="xdg-open"

xev_keyboard() {
  xev | awk -F'[ )]+' '/^KeyPress/ { a[NR+2] } NR in a { printf "%-3s %s\n", $5, $8 }'
}

mdd() {
  md $1
  cd $1
}

gbak() {
  git add --all
  git commit -m "backup: $(date +"%Y-%m-%d %H:%M")"
  git push origin
}

[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh
