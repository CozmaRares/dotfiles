session_root "/mnt/SSD/repos/practica"

if initialize_session "prac"; then
  new_window "nvim"
  run_cmd "nvim"
  new_window "tailwind"
  run_cmd "pnpm run dev:tailwind"
  new_window "php"
  run_cmd "pnpm run dev:php"
  new_window "term"
  select_window 1
fi

finalize_and_go_to_session
