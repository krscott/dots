# nixcfg

My home-manager nix config.

```sh
./switch.sh
```

## Derived config

To derive a config from this config (like for work or something), start with
`docs/derived-flake-template.nix`.

## TODO

- improvements from [this blog](https://www.josean.com/posts/7-amazing-cli-tools)
- Add zsh-forgit
- Switch tmux to zellij?
- Switch vim to nixvim?

## Extra setup

Depending on the system, some other manual setup is required.

### NixOS setup

Open nix shell with tools
```
nix-shell -p vim git
```

Generate SSH key
```
ssh-keygen -t ed25519 -C "your_email@example.com"
cat ~/.ssh/id_ed25519.pub
```

Add SSH key to github: https://github.com/settings/ssh/new

Clone and run setup
```
ssh-add
git clone git@github.com:krscott/nixcfg.git
cd nixcfg
./nixos-setup.sh
```

Edit new configuration:
- Setup videoDrivers
- Add home-manager module

### Enter key fixes

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

### Secrets setup

First time setup:
```
mkdir -p ~/.config/sops/age
# Generate new key
nix shell nixpkgs#age -c age-keygen -o ~/.config/sops/age/keys.txt
# Print public key (Copy into .sops.yaml keys)
nix shell nixpkgs#age -c age-keygen -y ~/.config/sops/age/keys.txt
# Edit secrets
sops secrets/secrets.yaml
```

Existing keys
```
mkdir -p ~/.config/sops/age
# Copy keys.txt to ~/.config/sops/age
```

Run init scripts
```
krs_rclone_init
```

### Virtualization

Bypass Win11 setup sign-in: https://www.tomshardware.com/how-to/install-windows-11-without-microsoft-account



