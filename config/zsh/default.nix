{ pkgs, lib, ... }: {
  programs.zsh = {
    enable = true;
    enableCompletion = true;
    autosuggestion.enable = true;
    syntaxHighlighting.enable = true;

    shellAliases = {
      cat = "bat --paging=never";
      ls = "eza --icons=always";
      ll = "ls -l";
      la = "ls -la";
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

    initExtra = ''
      source ~/.p10k.zsh
      export PATH="$PATH:$HOME/bin:$HOME/.local/bin:$HOME/go/bin"
      #Bun
      export PATH="/Users/kelvinkipruto/.bun/bin:$PATH"
      #Flutter
      export PATH="/Users/kelvinkipruto/sdk/flutter/bin:$PATH"
      #Java
      export PATH="/opt/homebrew/opt/openjdk@17/bin:$PATH"
      export JAVA_HOME="/opt/homebrew/opt/openjdk@17"
      #Dart
      export PATH="$PATH":"$HOME/.pub-cache/bin"
      #Mysql
      export PATH="/opt/homebrew/opt/mysql-client/bin:$PATH"
      #Android
      export ANDROID_HOME="/Users/kelvinkipruto/Library/Android/sdk"

      # PNPM
      export PNPM_STORE_DIR="/Users/kelvinkipruto/.pnpm-global-store"

      # Cargo
      export PATH="$HOME/.cargo/bin:$PATH"
      
    '';

  };
}
