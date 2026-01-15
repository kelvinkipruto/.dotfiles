{ pkgs, lib, config, userConfig, ... }:
let
  homeDir = config.home.homeDirectory;
  system = pkgs.stdenv.hostPlatform.system;
  shared = import ../../shared { inherit pkgs lib userConfig system; };
in
{
  programs.zsh = {
    enable = true;
    enableCompletion = true;
    autosuggestion.enable = true;
    syntaxHighlighting.enable = true;

    shellAliases =
      shared.aliases.shellAliases
      // lib.optionalAttrs pkgs.stdenv.isLinux { update = "sudo nixos-rebuild switch"; };
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
      eval "$(devbox global shellenv)"
    '';
  };
}
