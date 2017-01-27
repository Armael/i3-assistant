# i3-assistant

A small collection of tools to interact with i3

- **listen**: listen and print keyboard events
- **workspaces_allocator**: reacts to a keybind (mod4-dollar by default) and
    goes to a fresh unused worspace

## Build

```
opam pin add dmlenu https://github.com/the-lambda-church/dmlenu.git
opam pin add i3ipc https://github.com/Armael/ocaml-i3ipc.git
make
```
