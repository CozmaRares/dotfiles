session_root "~/Obsidian Vault"

if initialize_session "obsi"; then
  new_window
  run_cmd "nvim"
fi

finalize_and_go_to_session
