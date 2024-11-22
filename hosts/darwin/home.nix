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
        # cargo
        deno
        discord
        eza
        fira-code-nerdfont
        flameshot
        flutter
        gleam
        go
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
        php
        pipx
        pnpm
        python3Full
        python312Packages.pip
        raycast
        rectangle
        rustup
        slack
        spotify
        stockfish
        telegram-desktop
        temurin-bin
        utm
        uv
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
