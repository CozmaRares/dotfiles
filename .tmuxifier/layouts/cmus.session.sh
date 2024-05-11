session_root "~"

if initialize_session "cmus"; then
  new_window "cmus"
  select_window 1
  run_cmd "cmus"
fi

finalize_and_go_to_session
