{ pkgs, lib, config, ... }:
let
  cfg = config.programs.zsh;
  homeDir = config.home.homeDirectory;
  sharedAliases = {
    # File and directory operations
    cat = "bat --paging=never";
    ls = "eza --icons=always --color=always --group-directories-first";
    ll = "eza --icons=always --color=always --group-directories-first -l";
    la = "eza --icons=always --color=always --group-directories-first -la";
    lt = "eza --tree";

    # Git and development
    lg = "lazygit";

    # System maintenance
    clean = "nix-collect-garbage -d && sudo nix-collect-garbage -d";

    # Common shortcuts
    grep = "rg";
    find = "fd";
    top = "htop";

    # Docker shortcuts
    dc = "docker-compose";
    dcu = "docker-compose up";
    dcd = "docker-compose down";
    dcb = "docker-compose build";

    # Nix shortcuts
    nix-search = "nix search nixpkgs";
    nix-shell = "nix-shell --run zsh";
  };
in
{
  programs.zsh = {
    enable = true;
    enableCompletion = true;
    autosuggestion.enable = true;
    syntaxHighlighting.enable = true;

    shellAliases = sharedAliases // {
      # System-specific aliases can be added here
      update = "sudo nixos-rebuild switch";
    };
    history.size = 10000;

    # Oh my zsh setup
    oh-my-zsh = {
      enable = true;
      plugins = [ "bun" "deno" "docker" "docker-compose" "gh" "git" "history" "node" "npm" "vscode" ];
      theme = "robbyrussell";
    };

    plugins = [
      {
        name = "powerlevel10k";
        src = pkgs.zsh-powerlevel10k;
        file = "share/zsh-powerlevel10k/powerlevel10k.zsh-theme";
      }
      {
        name = "zsh-autosuggestions";
        src = pkgs.zsh-autosuggestions;
      }
      {
        name = "zsh-syntax-highlighting";
        src = pkgs.zsh-syntax-highlighting;
      }
      {
        name = "zsh-completions";
        src = pkgs.zsh-completions;
      }
      {
        name = "zsh-history-substring-search";
        src = pkgs.zsh-history-substring-search;
      }
      {
        name = "zsh-nix-shell";
        src = pkgs.zsh-nix-shell;
      }
    ];

    initContent = ''
      # Source p10k configuration from dotfiles
      if [ -f "${homeDir}/.dotfiles/config/zsh/p10k.zsh" ]; then
        source "${homeDir}/.dotfiles/config/zsh/p10k.zsh"
      elif [ -f "~/.p10k.zsh" ]; then
        source ~/.p10k.zsh
      fi
      # export PATH="$PATH:$HOME/bin:$HOME/.local/bin:$HOME/go/bin"
      #Bun
      # export PATH="${homeDir}/.bun/bin:$PATH"
      #Flutter
      # export PATH="${homeDir}/sdk/flutter/bin:$PATH"
      #Java
      # export PATH="/opt/homebrew/opt/openjdk@17/bin:$PATH"
      # export JAVA_HOME="/opt/homebrew/opt/openjdk@17"
      #Dart
      # export PATH="$PATH":"${homeDir}/.pub-cache/bin"
      #Mysql
      # export PATH="/opt/homebrew/opt/mysql-client/bin:$PATH"
      #Android
      # export ANDROID_HOME="${homeDir}/Library/Android/sdk"
      # export PATH=$PATH:$ANDROID_HOME/emulator
      # export PATH=$PATH:$ANDROID_HOME/platform-tools

      # Cargo
      # export PATH="$HOME/.cargo/bin:$PATH"
      # Mise
      eval "$(mise activate zsh)"
    '';
  };
}
