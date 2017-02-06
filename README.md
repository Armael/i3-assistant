# i3-assistant

A small collection of tools to interact with i3, using [ocaml-i3ipc](https://github.com/Armael/ocaml-i3ipc).

- **listen**: listen and print keyboard events
- **workspaces_allocator**: reacts to a keybind (mod4+keycode 49 by default —
    the upper-left key) and goes to a fresh unused worspace

## Build

```
opam pin add i3ipc https://github.com/Armael/ocaml-i3ipc.git
make
```
