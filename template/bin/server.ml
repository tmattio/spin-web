let app = App_web.app |> Opium.App.of_rock |> Opium.App.cmd_name "{{ project_name }}"

let log_level = Logs.Debug

let () =
  Logs.set_reporter (Logs_fmt.reporter ());
  Logs.set_level (Some log_level);
  Opium.App.run_command app