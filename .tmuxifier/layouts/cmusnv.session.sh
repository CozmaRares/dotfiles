session_root "."

if initialize_session "cmusnv"; then
  new_window "cmus"
  new_window "nvim"
  new_window "term"
  select_window 2
  run_cmd "nvim"
  select_window 1
  run_cmd "cmus"
fi

finalize_and_go_to_session
