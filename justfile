set shell := ["zsh", "-c"]

darwin_host := "kelvinkipruto"
nixos_host := "kelvinkipruto"

# List available commands
default:
  just --list

# Format all Nix files
fmt:
  nixpkgs-fmt $(find . -name '*.nix' -not -path './.git/*')

# Build the macOS system without switching
build-darwin:
  nix build .#darwinConfigurations.{{darwin_host}}.system

# Dry-run the macOS system build
check-darwin:
  nix build .#darwinConfigurations.{{darwin_host}}.system --dry-run

# Apply the macOS system config. nix-darwin system activation runs as root.
switch-darwin:
  sudo darwin-rebuild switch --flake .#{{darwin_host}}

# Build the NixOS system without switching
build-nixos:
  nix build .#nixosConfigurations.{{nixos_host}}.config.system.build.toplevel

# Show declared and locally installed toolchains
audit-tools:
  #!/usr/bin/env zsh
  set -euo pipefail

  print "== mise config =="
  sed -n '1,120p' "$HOME/.config/mise/config.toml" 2>/dev/null || true

  print "\n== active language commands =="
  type -a node npm bun deno go python python3 uv uvx rustc cargo rustup java javac kotlin kotlinc dotnet dart flutter php lua elixir 2>/dev/null || true

  print "\n== mise installs by size =="
  du -sh "$HOME"/.local/share/mise/installs/* 2>/dev/null | sort -h || true

  print "\n== manual rustup/cargo =="
  du -sh "$HOME"/.rustup "$HOME"/.cargo 2>/dev/null || true

  print "\n== project language markers =="
  roots=("$HOME/engineering" "$HOME/dev" "$HOME/crypto" "$HOME/Learn" "$HOME/interviews" "$HOME/frappe")
  find "${roots[@]}" \
    -path '*/node_modules/*' -prune -o \
    -path '*/.git/*' -prune -o \
    -path '*/.venv/*' -prune -o \
    -path '*/env/*' -prune -o \
    \( -name 'Cargo.toml' -o -name 'go.mod' -o -name 'mix.exs' -o -name 'pubspec.yaml' -o -name '*.csproj' -o -name '*.fsproj' -o -name 'build.gradle' -o -name 'build.gradle.kts' -o -name 'pom.xml' -o -name 'gleam.toml' -o -name 'dune-project' -o -name 'pyproject.toml' -o -name 'package.json' \) \
    -print 2>/dev/null \
    | sed 's#.*Cargo.toml#Rust#; s#.*go.mod#Go#; s#.*mix.exs#Elixir#; s#.*pubspec.yaml#Flutter/Dart#; s#.*\.csproj#Dotnet#; s#.*\.fsproj#Dotnet#; s#.*build.gradle.*#Gradle/Kotlin/Java#; s#.*pom.xml#Maven/Java#; s#.*gleam.toml#Gleam#; s#.*dune-project#OCaml#; s#.*pyproject.toml#Python#; s#.*package.json#Node/JS#' \
    | sort \
    | uniq -c \
    | sort -nr
