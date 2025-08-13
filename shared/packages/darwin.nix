{ pkgs, ... }:
# Darwin (macOS) specific packages
[
  # macOS specific development tools
  pkgs.cocoapods
  pkgs.colima
  pkgs.docker
  pkgs.fnm
  pkgs.mise
  pkgs.pipx
  pkgs.python312Packages.pip
  pkgs.uv
  pkgs.watchman

  # macOS specific applications
  pkgs.alacritty
  pkgs.raycast
  pkgs.rectangle
  pkgs.slack
  pkgs.slack-cli

  # Development and reverse engineering tools
  pkgs.apktool
  pkgs.asdf-vm
  pkgs.cloudflared
  pkgs.dex2jar
  pkgs.frida-tools
  pkgs.gleam
  pkgs.git-lfs
  pkgs.httrack
  pkgs.jadx
  pkgs.kotlin
  pkgs.lazydocker
  pkgs.localsend
  pkgs.nmap
  pkgs.ngrok
  pkgs.nixd
  pkgs.ocaml
  pkgs.stockfish
  pkgs.turso-cli

  # Media tools
  pkgs.ffmpeg
]