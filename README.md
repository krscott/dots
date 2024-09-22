# nixcfg

My home-manager nix config.

```sh
./switch-home.sh
```

## Derived config

To derive a config from this config (like for work or something), start with
`docs/derived-flake-template.nix`.

## TODO

- improvements from [this blog](https://www.josean.com/posts/7-amazing-cli-tools)
- Add zsh-forgit
- Switch tmux to zellij?
- Switch vim to nixvim?

## Enter key fixes

Some terminals have trouble with modfiers. See:
- https://stackoverflow.com/questions/16359878/how-to-map-shift-enter
- https://github.com/microsoft/terminal/issues/530#issuecomment-755917602

tldr for windows, add this to terminal settings json:
```json
{ "command": {"action": "sendInput", "input": "\u001b[13;2u" }, "keys": "shift+enter" },
{ "command": {"action": "sendInput", "input": "\u001b[13;5u" }, "keys": "ctrl+enter" },
{ "command": {"action": "sendInput", "input": "\u001b[13;6u" }, "keys": "ctrl+shift+enter" },
{ "command": {"action": "sendInput", "input": "\u001b[32;2u" }, "keys": "shift+space" },
{ "command": {"action": "sendInput", "input": "\u001b[32;5u" }, "keys": "ctrl+space" },
{ "command": {"action": "sendInput", "input": "\u001b[32;6u" }, "keys": "ctrl+shift+space" },
```

## Secrets setup

```
mkdir -p ~/.config/sops/age
nix shell nixpkgs#age -c age-keygen -o ~/.config/sops/age/keys.txt
# (Paste key into .sops.yaml)
sops secrets/secrets.yaml
```
