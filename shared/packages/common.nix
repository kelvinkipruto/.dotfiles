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
[
  # Development tools
  pkgs.android-tools
  pkgs.cmake
  # pkgs.bat # Managed via programs.bat
  # pkgs.bun
  # pkgs.cargo # Managed via mise/rust
  pkgs.cloudflared
  # pkgs.deno
  pkgs.ffmpeg
  pkgs.fastfetch
  # pkgs.fnm
  # pkgs.git # Managed via programs.git
  # pkgs.gh # Managed via programs.gh
  pkgs.git-lfs
  # pkgs.go
  pkgs.httrack
  # pkgs.kotlin # Managed via mise
  pkgs.lazydocker
  pkgs.mise
  # pkgs.neovim # Managed via programs.neovim
  pkgs.ngrok
  pkgs.nixd
  pkgs.nixpkgs-fmt
  pkgs.statix
  pkgs.deadnix
  pkgs.nmap
  # pkgs.obsidian
  phpWithXdebug
  pkgs.pipx
  # pkgs.python3Full
  # pkgs.ripgrep # Managed via programs.ripgrep
  # pkgs.rustup # Managed via mise/rust
  pkgs.slack-cli
  pkgs.stockfish
  # pkgs.telegram-desktop
  pkgs.turso-cli
  pkgs.unzip
  # pkgs.uv # Managed via mise
  # pkgs.zoxide # Managed via programs.zoxide

  # Browsers
  # GUI browsers are installed via Homebrew casks on Darwin and NixOS-specific packages on Linux.
  # pkgs.brave
  # pkgs.firefox-bin
  # pkgs.firefox-devedition

  # Applications
  # pkgs.alacritty # Managed via programs.alacritty
  pkgs.colima
  pkgs.docker
  # pkgs.kitty # Managed via programs.kitty on Linux and Homebrew cask on Darwin
  pkgs.duckdb

  # Media and utilities
  # pkgs.flameshot # Managed via Homebrew cask on Darwin and NixOS-specific packages on Linux
  # pkgs.spotify # Managed via Homebrew cask on Darwin and NixOS-specific packages on Linux
  pkgs.yt-dlp
  pkgs.zip
  pkgs.unrar
  pkgs.croc

  pkgs.wget
  # pkgs.imhex # Managed via Homebrew cask on Darwin and NixOS-specific packages on Linux

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
  pkgs.bottom
  pkgs.dua
  pkgs.duf
  pkgs.nushell
  pkgs.just
  pkgs.tokei

  #Misc
  pkgs.poppler
  pkgs.imagemagick
  pkgs.resvg

  # pdf
  pkgs.qpdf
  # pkgs.wkhtmltopdf

  #other
  # pkgs.qbittorrent
  pkgs.mkcert

  #raylib
  pkgs.raylib

  #c++
  # pkgs.vcpkg
  # pkgs.ninja

  #db
  pkgs.redis
  pkgs.mongodb-tools

  #other
  pkgs.pkg-config
  pkgs.dnsmasq

  #Android
  pkgs.scrcpy
  # pkgs.flutter # Managed via mise
]
