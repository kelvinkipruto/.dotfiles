{ pkgs, ... }:
# Shared program configurations for both Darwin and NixOS
{
  home-manager = {
    enable = true;
  };

  # Note: alacritty configuration is handled by config/alacritty/default.nix

  bat = {
    enable = true;
    config = {
      theme = "TwoDark";
      pager = "less -FR";
    };
  };

  eza = {
    enable = true;
    enableZshIntegration = true;
    git = true;
    icons = "auto";
  };

  fd = {
    enable = true;
  };

  fzf = {
    enable = true;
    enableZshIntegration = true;
    defaultCommand = "fd --type f";
    defaultOptions = [ "--height 40%" "--border" ];
  };

  htop = {
    enable = true;
    settings = {
      show_cpu_frequency = true;
      show_cpu_temperature = true;
    };
  };

  jq = {
    enable = true;
  };

  lazygit = {
    enable = true;
  };

  # Note: git configuration is handled by config/git/default.nix

  # Note: gh configuration is handled by config/gh/default.nix
  # Note: gpg configuration is handled by config/gpg/default.nix

  # Editors
  neovim = {
    enable = true;
    defaultEditor = true;
    viAlias = true;
    vimAlias = true;
  };

  # Shell integration
  direnv = {
    enable = true;
    enableBashIntegration = true;
    enableZshIntegration = true;
    nix-direnv.enable = true;
  };

  ripgrep = {
    enable = true;
  };

  zoxide = {
    enable = true;
    enableZshIntegration = true;
  };



}
