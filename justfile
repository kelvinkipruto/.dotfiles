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

# Show Nix disk usage, roots, and scratch directories that GC will not remove
audit-nix:
  #!/usr/bin/env zsh
  set -euo pipefail
  setopt null_glob

  print "== nix volume =="
  df -h /nix 2>/dev/null || true

  print "\n== nix sizes =="
  du -sh /nix /nix/store /nix/var/nix /nix/var/nix/builds 2>/dev/null || true

  print "\n== gc dry run =="
  nix store gc --dry-run || true

  print "\n== important roots =="
  roots=(
    /nix/var/nix/profiles/system
    /nix/var/nix/profiles/default
    "$HOME/.dotfiles/result"
    "$HOME/.local/state/home-manager/gcroots/current-home"
    "$HOME/.local/state/nix/profiles/home-manager"
    "$HOME/.local/state/nix/profiles"/home-manager-*-link
    "$HOME/.local/share/devbox/global/default/.devbox/nix/profile/default"
  )
  for root in $roots; do
    [[ -e "$root" || -L "$root" ]] || continue
    print "\n$root"
    readlink "$root" 2>/dev/null || true
    nix path-info -Sh "$root" 2>/dev/null || true
  done

  print "\n== build scratch =="
  builds=(/nix/var/nix/builds/*)
  if (( ${#builds} )); then
    du -sh $builds 2>/dev/null | sort -h || true
  else
    print "none"
  fi

  print "\n== gc roots =="
  root_count=$(nix-store --gc --print-roots 2>/dev/null | wc -l | tr -d ' ')
  print "$root_count roots known to Nix; important persistent roots are listed above."

# Run normal Nix garbage collection and show whether anything remains collectible
clean-nix:
  #!/usr/bin/env zsh
  set -euo pipefail

  nix-collect-garbage -d
  sudo nix-collect-garbage -d

  print "\n== remaining garbage =="
  nix store gc --dry-run || true
  print "\nRun 'just audit-nix' if disk usage still looks high."

# Clean Homebrew downloads and old versions when Homebrew is available
clean-brew:
  #!/usr/bin/env zsh
  set -euo pipefail

  if command -v brew >/dev/null 2>&1; then
    brew cleanup --prune=all
  else
    print "Homebrew not found; skipping."
  fi

# Prune mise-managed tool versions no longer referenced by tracked configs
clean-mise:
  #!/usr/bin/env zsh
  set -euo pipefail

  if command -v mise >/dev/null 2>&1; then
    mise prune --yes
  else
    print "mise not found; skipping."
  fi

# Clean safe package-manager leftovers across configured systems
clean: clean-nix clean-mise clean-brew

# Deduplicate identical files in the Nix store
optimise-nix:
  nix store optimise

# Run full Nix maintenance: GC, store optimisation, and a final audit
maintain-nix: clean-nix optimise-nix audit-nix

# Install, reshim, and prune mise-managed tools
maintain-mise:
  #!/usr/bin/env zsh
  set -euo pipefail

  if command -v mise >/dev/null 2>&1; then
    mise install --yes
    mise reshim
    mise prune --yes
  else
    print "mise not found; skipping."
  fi

# Update Homebrew outside nix-darwin activation
maintain-brew:
  #!/usr/bin/env zsh
  set -euo pipefail

  if command -v brew >/dev/null 2>&1; then
    brew update
    brew upgrade --greedy
    brew cleanup --prune=all
  else
    print "Homebrew not found; skipping."
  fi

# Run broad package-manager maintenance across configured systems
maintain: maintain-nix maintain-mise maintain-brew

# Show declared and locally installed toolchains
audit-tools:
  #!/usr/bin/env zsh
  set -euo pipefail

  print "== mise config =="
  sed -n '1,120p' "$HOME/.config/mise/config.toml" 2>/dev/null || true

  print "\n== active language commands =="
  type -a mise node npm bun deno go python python3 uv uvx rustc cargo rustup java javac kotlin kotlinc dotnet dart flutter php lua elixir 2>/dev/null || true

  print "\n== mise installs by size =="
  du -sh "$HOME"/.local/share/mise/installs/* 2>/dev/null | sort -h || true

  print "\n== mise sidecar data by size =="
  du -sh "$HOME"/.local/share/mise/dotnet-root "$HOME"/.local/share/mise/rustup "$HOME"/.local/share/mise/cargo 2>/dev/null | sort -h || true

  print "\n== mise prunable candidates =="
  mise ls --prunable 2>/dev/null || true

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
