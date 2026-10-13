{ pkgs, ... }:
# NixOS (Linux) specific packages
[
  # Linux specific applications
  pkgs.chromium
  pkgs.brave
  pkgs.discord
  pkgs.firefox-devedition
  pkgs.flameshot
  pkgs.floorp-bin
  pkgs.imhex
  pkgs.localsend
  pkgs.slack
  pkgs.spotify
  pkgs.vscode

  # Linux desktop environment tools
  pkgs.dunst
  pkgs.rofi
  # pkgs.waybar
  # pkgs.wofi
  # pkgs.swww
  # pkgs.variety
  pkgs.picom
  pkgs.libnotify
  pkgs.pavucontrol

  # Wayland/X11 tools
  # pkgs.wayland-protocols
  # pkgs.wayland-utils
  # pkgs.wl-clipboard
  pkgs.xclip
  pkgs.xdg-desktop-portal-gtk
  # pkgs.xdg-desktop-portal-hyprland
  # pkgs.xwayland

  # X11 libraries
  pkgs.libx11
  pkgs.libx11.dev
  pkgs.libxcb
  pkgs.libxft
  pkgs.libxinerama
  pkgs.xinit
  pkgs.xinput

  # Development tools
  # pkgs.flutter # Managed via mise
  pkgs.docker
  pkgs.gcc
  pkgs.gparted
  pkgs.kubectl
  pkgs.meson
  pkgs.mise
  pkgs.qemu
  pkgs.supabase-cli
  pkgs.yarn

  # System tools
  pkgs.flatpak
  pkgs.fontconfig
  pkgs.freetype
  pkgs.gnome-keyring
  pkgs.gnugrep
  pkgs.gnumake
  pkgs.mangohud
  pkgs.fastfetch
  pkgs.nil
  pkgs.starship
  pkgs.nerd-fonts.terminess-ttf
  pkgs.tldr
  pkgs.thunar

  # Shell enhancements
  pkgs.oh-my-zsh
  pkgs.zsh-powerlevel10k
  pkgs.zsh-autosuggestions
  pkgs.zsh-syntax-highlighting
  pkgs.zsh-completions
  pkgs.zsh-history-substring-search
  pkgs.zsh-nix-shell
]
