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
    stateVersion = "25.05";

    packages = with pkgs;
      [
        alacritty
        android-tools
        apktool
        # android-studio
        asdf-vm
        bat
        bun
        # cargo
        cloudflared
        cocoapods
        colima
        deno
        dex2jar
        # discord
        docker
        eza
        nerd-fonts.fira-code
        ffmpeg
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
        mise
        # nerdfonts
        nmap
        ngrok
        nixpkgs-fmt
        ocaml
        obsidian
        ollama
        pipx
        python3Full
        python312Packages.pip
        raycast
        rectangle
        rustup
        slack
        slack-cli
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
        watchman
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
