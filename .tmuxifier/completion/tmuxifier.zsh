# Ensure the completion system is initialized
autoload -Uz compinit
compinit

# Define the tmuxifier completion function
_tmuxifier() {
  local -a completions

  if (( CURRENT == 2 )); then
    completions=("${(@f)$(tmuxifier commands)}")
    _values 'tmuxifier commands' $completions
  else
    completions=("${(@f)$(tmuxifier completions "${words[2]}")}")
    _values 'tmuxifier command completions' $completions
  fi
}

# Register the completion function for the tmuxifier command
compdef _tmuxifier tmuxifier
