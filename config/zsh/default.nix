{ pkgs, lib, config, ... }:
let
  cfg = config.programs.zsh;
  homeDir = config.home.homeDirectory;
in
{
  programs.zsh = {
    enable = true;
    enableCompletion = true;
    autosuggestion.enable = true;
    syntaxHighlighting.enable = true;

    shellAliases = {
      cat = "bat --paging=never";
      ls = "eza --icons=always --color=always --group-directories-first";
      ll = "eza --icons=always --color=always --group-directories-first -l";
      la = "eza --icons=always --color=always --group-directories-first -la";
      lt = "eza --tree";
      lg = "lazygit";
      update = "sudo nixos-rebuild switch";
      clean = "sudo nix-collect-garbage -d";
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
      source ~/.p10k.zsh
      export PATH="$PATH:$HOME/bin:$HOME/.local/bin:$HOME/go/bin"
      #Bun
      export PATH="${homeDir}/.bun/bin:$PATH"
      #Flutter
      export PATH="${homeDir}/sdk/flutter/bin:$PATH"
      #Java
      export PATH="/opt/homebrew/opt/openjdk@17/bin:$PATH"
      export JAVA_HOME="/opt/homebrew/opt/openjdk@17"
      #Dart
      export PATH="$PATH":"${homeDir}/.pub-cache/bin"
      #Mysql
      export PATH="/opt/homebrew/opt/mysql-client/bin:$PATH"
      #Android
      export ANDROID_HOME="${homeDir}/Library/Android/sdk"
      export PATH=$PATH:$ANDROID_HOME/emulator
      export PATH=$PATH:$ANDROID_HOME/platform-tools

      # Cargo
      export PATH="$HOME/.cargo/bin:$PATH"

      # FNM
      eval "$(fnm env --use-on-cd --shell zsh)"
    '';
  };
}
