open I3ipc
open Batteries
open Lwt.Infix

let fresh_workspace_name conn =
  let%lwt workspaces = get_workspaces conn in
  let names = List.map (fun (w: Reply.workspace) -> w.Reply.name) workspaces in
  let names_num = List.filter_map (fun n ->
    try Some (int_of_string n) with _ -> None) names in
  let rec loop n =
    if not (List.mem n names_num) then string_of_int n
    else loop (n+1) in
  Lwt.return (loop 1)

let go_to_fresh_workspace conn =
  let%lwt name = fresh_workspace_name conn in
  let%lwt _ = command conn ("workspace " ^ name) in
  Lwt.return ()

let is_keybind mods key binding =
  let open Event in
  binding.input_type = Keyboard &&
  binding.event_state_mask = mods &&
  binding.symbol = Some key

let is_keycode mods code binding =
  let open Event in
  binding.input_type = Keyboard &&
  binding.event_state_mask = mods &&
  binding.input_code = code

let rec loop conn =
  let open Event in
  match%lwt next_event conn with
  | Binding { binding; _ } ->
    (if is_keycode ["Mod4"] 49 binding then
       go_to_fresh_workspace conn
     else
       Lwt.return ()) >>= fun _ ->
    loop conn
  | _ ->
    loop conn

let main =
  let%lwt conn = connect () in
  let%lwt _ = subscribe conn [Binding] in
  loop conn

let () = Lwt_main.run main
