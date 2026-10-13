# Nix Dotfiles

Minimal Nix configuration for macOS (Darwin) and NixOS.

## Structure

```
├── config/                 # Shared application configurations
├── docs/                   # Usage docs for configured tools
│   ├── tools/              # Tool usage guides
│   └── workflows/          # Practical workflows
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
│   │   ├── profiles.nix   # Optional package profile definitions
│   │   └── default.nix    # Package set exports
│   ├── programs/
│   │   └── default.nix    # Shared program configurations
│   ├── aliases.nix        # Central shell aliases
│   ├── package-profiles.nix # Global package profile defaults
│   ├── user.nix           # Shared user metadata and home paths
│   └── default.nix        # Main shared exports
└── flake.nix              # Main flake configuration
```

## Usage

### Cross-platform

```bash
# Build the current OS system
just build

# Apply the current OS system
just switch

# Clean safe package-manager leftovers
just clean

# Run broader maintenance across Nix, mise, and Homebrew
just maintain
```

### Updates

```bash
# Update inputs only
just update

# Update inputs and build the current OS system
just update-check

# Update inputs, build, and switch
just update-switch
```

### System-specific commands

```bash
# macOS
just build-darwin
just switch-darwin

# NixOS
just build-nixos
just switch-nixos
```

### Development Shell

```bash
nix develop
```

For program and workflow docs, see `docs/README.md`.
