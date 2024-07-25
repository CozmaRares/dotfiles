session_root "/mnt/SSD/repos/practica"

if initialize_session "prac"; then
  new_window "nvim"
  run_cmd "nvim"

  new_window "client"
  run_cmd "pnpm run dev:client"

  new_window
  run_cmd "docker compose up -d"

  select_window 1
fi

finalize_and_go_to_session
