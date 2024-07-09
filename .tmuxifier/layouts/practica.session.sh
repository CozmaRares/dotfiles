session_root "/mnt/SSD/repos/practica"

if initialize_session "prac"; then
  new_window "nvim"
  run_cmd "nvim"
  new_window "server"
  run_cmd "pnpm run dev:server"
  split_h 25
  new_window "client"
  run_cmd "pnpm run dev:client"
  split_h 25
  new_window "term"
  select_window 1
fi

finalize_and_go_to_session
