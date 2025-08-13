# Nix Dotfiles

A well-structured Nix configuration for both macOS (Darwin) and NixOS systems.

## Structure

```
├── config/                 # Shared application configurations
├── hosts/
│   ├── darwin/            # macOS-specific configurations
│   └── nixos/             # NixOS-specific configurations
├── shared/                # Shared packages and programs
│   ├── packages/
│   │   ├── common.nix     # Packages shared between both systems
│   │   ├── darwin.nix     # macOS-specific packages
│   │   ├── nixos.nix      # NixOS-specific packages
│   │   └── default.nix    # Package set exports
│   ├── programs/
│   │   └── default.nix    # Shared program configurations
│   └── default.nix        # Main shared exports
└── flake.nix              # Main flake configuration
```

## Features

- **Shared Package Management**: Common packages are defined once and reused across systems
- **OS-Specific Packages**: Platform-specific packages are organized separately
- **Stable + Unstable**: Uses nixpkgs-unstable by default with stable packages available via `pkgs.stable.*`
- **Modular Structure**: Easy to maintain and extend
- **Program Configurations**: Shared program settings across both systems

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

### Development Shell

```bash
nix develop
```

## Package Management

### Adding Packages

- **Common packages** (both systems): Add to `shared/packages/common.nix`
- **macOS-only packages**: Add to `shared/packages/darwin.nix`
- **NixOS-only packages**: Add to `shared/packages/nixos.nix`

### Using Stable Packages

By default, packages come from nixpkgs-unstable. To use a stable version:

```nix
# In any package list
pkgs.stable.packageName  # Uses stable version
pkgs.packageName         # Uses unstable version (default)
```

## Program Configurations

Shared program configurations are in `shared/programs/default.nix`. OS-specific overrides can be added in the respective `home.nix` files.

## Customization

1. **System-specific packages**: Add to the respective host's `home.nix` file
2. **Program overrides**: Use the merge operator `//` in the programs section
3. **New shared programs**: Add to `shared/programs/default.nix`

## Architecture

This configuration follows Nix best practices:

- **DRY Principle**: No duplication between Darwin and NixOS configurations
- **Modularity**: Each component has a single responsibility
- **Flexibility**: Easy to add new systems or modify existing ones
- **Maintainability**: Clear structure makes updates straightforward