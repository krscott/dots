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

## Secrets setup

```
mkdir -p ~/.config/sops/age
nix shell nixpkgs#age -c age-keygen -o ~/.config/sops/age/keys.txt
# (Paste key into .sops.yaml)
sops secrets/secrets.yaml
```
