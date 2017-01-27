open I3ipc

let rec loop conn =
  match%lwt next_event conn with
  | Event.Binding { Event.binding; _ } ->
    let open Event in
    if binding.input_type = Keyboard then
      Format.fprintf Format.std_formatter
        "%a\n%!" Event.pp_binding binding;
    loop conn
  | _ ->
    loop conn

let () = Lwt_main.run (
  let%lwt conn = connect () in
  let%lwt _ = subscribe conn [Binding] in
  Printf.printf "starting loop...\n%!";
  loop conn
)
