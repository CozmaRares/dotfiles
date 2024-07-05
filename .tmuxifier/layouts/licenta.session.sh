session_root "/mnt/SSD/tucn/licenta"

if initialize_session "lic"; then
  new_window "nvim"
  run_cmd "nvim"
  new_window "cargo"
  select_window 1
fi

finalize_and_go_to_session
