{ pkgs, ... }:
# NixOS (Linux) specific packages
[
  # Linux specific applications
  pkgs.chromium
  pkgs.discord
  pkgs.floorp
  pkgs.vscode

  # Linux desktop environment tools
  pkgs.dunst
  pkgs.rofi-wayland
  pkgs.waybar
  pkgs.wofi
  pkgs.swww
  pkgs.variety
  pkgs.picom
  pkgs.libnotify
  pkgs.pavucontrol

  # Wayland/X11 tools
  pkgs.wayland-protocols
  pkgs.wayland-utils
  pkgs.wl-clipboard
  pkgs.wlroots
  pkgs.xclip
  pkgs.xdg-desktop-portal-gtk
  pkgs.xdg-desktop-portal-hyprland
  pkgs.xwayland

  # X11 libraries
  pkgs.xorg.libX11
  pkgs.xorg.libX11.dev
  pkgs.xorg.libxcb
  pkgs.xorg.libXft
  pkgs.xorg.libXinerama
  pkgs.xorg.xinit
  pkgs.xorg.xinput

  # Development tools
  pkgs.dbeaver-bin
  pkgs.flutter
  pkgs.gcc
  pkgs.github-desktop
  pkgs.gparted
  pkgs.meson
  pkgs.powershell
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
  pkgs.neofetch
  pkgs.nil
  pkgs.starship
  pkgs.nerd-fonts.terminess-ttf
  pkgs.tldr
  pkgs.wpsoffice
  pkgs.xfce.thunar

  # Gaming
  (pkgs.lutris.override {
    extraPkgs = pkgs: [
      pkgs.wineWowPackages.stable
      pkgs.winetricks
    ];
  })

  # Shell enhancements
  pkgs.oh-my-zsh
  pkgs.zsh-powerlevel10k
  pkgs.zsh-autosuggestions
  pkgs.zsh-syntax-highlighting
  pkgs.zsh-completions
  pkgs.zsh-history-substring-search
  pkgs.zsh-nix-shell
]
