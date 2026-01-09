# Repository Guidelines

## Project Structure & Module Organization
- `flake.nix` and `flake.lock` define the Nix flake entry point and inputs.
- `hosts/` contains host-specific configurations:
  - `hosts/darwin/` for macOS (nix-darwin).
  - `hosts/nixos/` for NixOS (system + `config/` like Hyprland).
- `shared/` holds reusable packages, programs, environment, fonts, and user settings.
- `config/` stores app-specific config modules (zsh, git, tmux, kitty, etc.).
- `scripts/` contains helper scripts (e.g., `scripts/install-mise-tools.sh`).

## Build, Test, and Development Commands
- `nix run nix-darwin -- switch --flake .#kelvinkipruto` applies macOS config.
- `nix build .#darwinConfigurations.kelvinkipruto.system` builds macOS config only.
- `sudo nixos-rebuild switch --flake .#kelvinkipruto` applies NixOS config.
- `nix build .#nixosConfigurations.kelvinkipruto.config.system.build.toplevel` builds NixOS config only.
- `nix develop` enters the dev shell defined by the flake.

## Coding Style & Naming Conventions
- Nix files use 2-space indentation and a compact attribute-set style.
- Keep modules small and focused; prefer new files in `shared/` or `config/` over large monoliths.
- Use lowercase, hyphenated filenames for new modules (e.g., `config/new-tool/default.nix`).

## Testing Guidelines
- No automated tests are currently defined. Validate changes by building the relevant target:
  - macOS: `nix build .#darwinConfigurations.kelvinkipruto.system`
  - NixOS: `nix build .#nixosConfigurations.kelvinkipruto.config.system.build.toplevel`

## Commit & Pull Request Guidelines
- Commit messages follow Conventional Commits (examples in history):
  - `feat(scope): add ...`, `fix: ...`, `chore: ...`, `build: ...`, `refactor(git): ...`.
- Pull requests should include:
  - A short summary of intent and impacted hosts (`darwin`, `nixos`, or both).
  - The commands used to validate changes (build or switch).

## Security & Configuration Tips
- Keep secrets out of this repo; use host-level secrets tooling if needed.
- Prefer `shared/` for cross-platform changes and host files for OS-specific tweaks.
