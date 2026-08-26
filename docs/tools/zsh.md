Zsh

Purpose
- Primary shell with Oh My Zsh and powerlevel10k prompt.

Core setup
- Oh My Zsh enabled
- powerlevel10k theme sourced from config/zsh/p10k.zsh
- Autosuggestions, syntax highlighting, completions enabled

Aliases
- Shared aliases are in shared/aliases.nix
- Linux-only alias: update -> sudo -H nixos-rebuild switch (-H so Nix doesn't warn $HOME not owned by root)

Tooling hooks
- mise activates on shell start
- devbox global shellenv is loaded
