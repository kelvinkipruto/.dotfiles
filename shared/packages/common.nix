{ pkgs, ... }:
let
  phpWithXdebug = pkgs.php.buildEnv {
    extensions = ({ enabled, all }: enabled ++ (with all; [
      grpc
      xdebug
    ]));
    extraConfig = ''
      xdebug.mode = debug
      xdebug.start_with_request = yes
      xdebug.client_host = 127.0.0.1
      xdebug.client_port = 9003
      xdebug.remote_enable = true
      xdebug.remote_host = 127.0.0.1
      xdebug.remote_port = 9000
    '';
  };
in
# Common packages shared between Darwin and NixOS
  # Note: ollama uses stable version for better reliability
[
  # Development tools
  pkgs.android-tools
  pkgs.apktool
  pkgs.cmake
  # pkgs.bat # Managed via programs.bat
  # pkgs.bun
  # pkgs.cargo # Provided by rustup
  pkgs.cloudflared
  # pkgs.deno
  pkgs.dex2jar
  pkgs.ffmpeg
  # pkgs.fnm
  pkgs.frida-tools
  # pkgs.git # Managed via programs.git
  # pkgs.gh # Managed via programs.gh
  pkgs.git-lfs
  pkgs.gleam
  # pkgs.go
  pkgs.httrack
  pkgs.jadx
  pkgs.kotlin
  pkgs.lazydocker
  pkgs.lua
  pkgs.luarocks
  pkgs.mise
  # pkgs.neovim # Managed via programs.neovim
  pkgs.ngrok
  pkgs.nixd
  pkgs.nixpkgs-fmt
  pkgs.nmap
  pkgs.obsidian
  pkgs.ocaml
  pkgs.ollama # Using stable version
  phpWithXdebug
  pkgs.pipx
  # pkgs.python3Full
  # pkgs.ripgrep # Managed via programs.ripgrep
  # pkgs.rustup
  pkgs.slack-cli
  pkgs.stockfish
  pkgs.telegram-desktop
  pkgs.turso-cli
  pkgs.unzip
  pkgs.uv
  # pkgs.zoxide # Managed via programs.zoxide

  # Browsers
  pkgs.brave
  pkgs.firefox
  pkgs.firefox-devedition

  # Applications
  # pkgs.alacritty # Managed via programs.alacritty
  pkgs.colima
  pkgs.docker
  pkgs.kitty
  pkgs.duckdb

  # Fonts
  pkgs.nerd-fonts.fira-code

  # Media and utilities
  pkgs.flameshot
  pkgs.spotify
  pkgs.yt-dlp
  pkgs.zip
  pkgs.unrar

  pkgs.wget
  pkgs.imhex

  # Terminal and shell tools
  pkgs.zsh
  # pkgs.tmux # Managed via programs.tmux
  # pkgs.yazi # Managed via programs.yazi
  # pkgs.htop # Managed via programs.htop
  # pkgs.jq # Managed via programs.jq
  # pkgs.fd # Managed via programs.fd
  # pkgs.fzf # Managed via programs.fzf
  # pkgs.eza # Managed via programs.eza
  # pkgs.lazygit # Managed via programs.lazygit
  # pkgs.direnv # Managed via programs.direnv
  pkgs.nushell

  #Misc
  pkgs.poppler
  pkgs.imagemagick
  pkgs.resvg

  # dotnet
  pkgs.dotnet-sdk_9

  # pdf
  pkgs.qpdf

  #other
  pkgs.qbittorrent
  pkgs.mkcert
]
