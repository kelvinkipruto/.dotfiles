{ self, pkgs, ... }:
{
  programs = {
    # Zsh configuration is handled by home-manager in config/zsh/default.nix
    # Removing system-level zsh configuration to avoid conflicts
  };
}
