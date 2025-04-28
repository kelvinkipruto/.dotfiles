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
        apktool
        # android-studio
        bat
        bun
        # cargo
        cocoapods
        deno
        dex2jar
        # discord
        eza
        fira-code-nerdfont
        flameshot
        fnm
        frida-tools
        # TODO: Fix flutter, gradler issues
        # flutter
        gleam
        go
        git-lfs
        # gradle
        httrack
        jadx
        kotlin
        lazydocker
        # legcord
        localsend
        lua
        luarocks
        # nerdfonts
        nmap
        ngrok
        nixpkgs-fmt
        # nodejs
        ocaml
        obsidian
        ollama
        # php
        pipx
        # pnpm
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
        yt-dlp
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
    direnv ={
      enable=true;
      enableBashIntegration = true; 
      enableZshIntegration = true;

      nix-direnv.enable = true;
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
