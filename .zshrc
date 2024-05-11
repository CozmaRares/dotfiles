if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

export EDITOR=nvim
export ZSH="$HOME/.oh-my-zsh"
export PATH="$HOME/.tmuxifier/bin:$PATH"

ZSH_THEME="powerlevel10k/powerlevel10k"

HYPHEN_INSENSITIVE="true"

# zstyle ':omz:update' mode disabled  # disable automatic updates
zstyle ':omz:update' mode auto      # update automatically without asking
# zstyle ':omz:update' mode reminder  # just remind me to update when it's time

zstyle ':omz:update' frequency 7

# Uncomment the following line if pasting URLs and other text is messed up.
# DISABLE_MAGIC_FUNCTIONS="true"

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
)
source $ZSH/oh-my-zsh.sh
source $HOME/.cargo/env


alias ll='eza -lA --sd --group-directories-first'
alias ls='eza --group-directories-first'
alias cls='clear'
alias pnpmi='pnpm install'
alias pnpmd='pnpm install -D'
alias gcam="git commit --amend"
alias gcne="git commit --amend --no-edit"
alias vim=nvim
alias vi=nvim
alias v=nvim
alias t=tmuxifier
alias tx=tmux
alias txat="tmux a -t"
alias password="pass show -c"
alias wifi='~/.config/rofi/scripts/rofi-wifi-menu.sh'
alias bluetooth='~/.config/rofi/scripts/rofi-bluetooth'

xev_keyboard() {
  xev | awk -F'[ )]+' '/^KeyPress/ { a[NR+2] } NR in a { printf "%-3s %s\n", $5, $8 }'
}

mdd() {
  md $1
  cd $1
}

# package includes

eval "$(zoxide init zsh)"
eval "$(tmuxifier init -)"

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

[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh
