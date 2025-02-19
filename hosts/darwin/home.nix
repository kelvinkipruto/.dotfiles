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
        alacritty
        android-tools
        # android-studio
        bat
        bun
        # cargo
        cocoapods
        deno
        discord
        eza
        fira-code-nerdfont
        flameshot
        # TODO: Fix flutter, gradler issues
        # flutter
        gleam
        go
        # gradle
        httrack
        lazydocker
        localsend
        lua
        luarocks
        nerdfonts
        ngrok
        nixpkgs-fmt
        nodejs
        ocaml
        obsidian
        ollama
        # php
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
        # temurin-bin
        # TODO: utm permission errors
        # FIX chmod +uw ~/Library/Containers/com.utmapp.UTM/Data/Documents/[VM NAME].utm/Data/efi_vars.fd
        # utm
        turso-cli
        unrar
        uv
        # zed-editor
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
