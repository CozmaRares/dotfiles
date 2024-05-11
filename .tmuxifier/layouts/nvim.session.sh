session_root "."

if initialize_session "nvim"; then
  new_window "nvim"
  new_window "term"
  select_window 1
  run_cmd "nvim"
fi

finalize_and_go_to_session
