Zsh Usage

Shell features
- Oh My Zsh enabled with common dev plugins
- powerlevel10k theme with local config at `config/zsh/p10k.zsh`
- Autosuggestions, syntax highlighting, and completions enabled

Aliases
- Central aliases live in `shared/aliases.nix`
- Linux-only alias: `update` runs `sudo -H nixos-rebuild switch` ( `-H` resets HOME to /var/root so Nix doesn't warn about ownership)

Tooling
- `mise` and `devbox` are auto-activated in `initContent`

Notes
- If you want to manage PATH entries, prefer `shared/environment.nix`.

Full docs: docs/tools/zsh.md
