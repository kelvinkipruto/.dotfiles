{ pkgs, ... }:
let
  # TODO: investigate how to share applications between nixos and darwin
  # sharedApps = import ../../shared { inherit pkgs; };
in
{
  imports = [
    ../../config
  ];
  home = {
    stateVersion = "23.11";

    packages = with pkgs;
      [
        android-tools
        bat
        bun
        cargo
        deno
        discord
        eza
        fira-code-nerdfont
        flameshot
        flutter
        gleam
        httrack
        lazydocker
        localsend
        lua
        luarocks
        nerdfonts
        nixpkgs-fmt
        nodejs
        obsidian
        ollama
        pnpm
        python3Full
        raycast
        rectangle
        slack
        spotify
        telegram-desktop
        zip
      ];
  };

  programs = {
    home-manager = {
      enable = true;
    };
    bat = {
      enable = true;
    };
    eza = {
      enable = true;
      enableZshIntegration = true;
    };
    fd = {
      enable = true;
    };
    fzf = {
      enable = true;
      enableZshIntegration = true;
    };
    htop = {
      enable = true;
    };
    jq = {
      enable = true;
    };
    lazygit = {
      enable = true;
    };
    neovim = {
      enable = true;
    };
    ripgrep = {
      enable = true;
    };
    tmux = {
      enable = true;
    };
    zoxide = {
      enable = true;
      enableZshIntegration = true;
    };

  };
}
