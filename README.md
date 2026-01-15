# Nix Dotfiles

Minimal Nix configuration for macOS (Darwin) and NixOS.

## Structure

```
├── config/                 # Shared application configurations
├── docs/                   # Usage docs for configured tools
├── hosts/
│   ├── darwin/            # macOS-specific configurations
│   └── nixos/             # NixOS-specific configurations
├── shared/                # Shared packages and programs
│   ├── home-manager/      # Shared Home Manager module
│   ├── modules/           # Shared system modules
│   ├── packages/
│   │   ├── common.nix     # Packages shared between both systems
│   │   ├── darwin.nix     # macOS-specific packages
│   │   ├── nixos.nix      # NixOS-specific packages
│   │   └── default.nix    # Package set exports
│   ├── programs/
│   │   └── default.nix    # Shared program configurations
│   ├── aliases.nix        # Central shell aliases
│   ├── user.nix           # Shared user metadata and home paths
│   └── default.nix        # Main shared exports
└── flake.nix              # Main flake configuration
```

## Usage

### macOS (Darwin)

```bash
# Build and switch
nix run nix-darwin -- switch --flake .#kelvinkipruto

# Build only
nix build .#darwinConfigurations.kelvinkipruto.system
```

### NixOS

```bash
# Build and switch
sudo nixos-rebuild switch --flake .#kelvinkipruto

# Build only
nix build .#nixosConfigurations.kelvinkipruto.config.system.build.toplevel
```

### NixOS (aarch64)

```bash
# Build and switch
sudo nixos-rebuild switch --flake .#kelvinkipruto-aarch64

# Build only
nix build .#nixosConfigurations.kelvinkipruto-aarch64.config.system.build.toplevel
```

### Development Shell

```bash
nix develop
```

For program usage docs, see `docs/README.md`.
