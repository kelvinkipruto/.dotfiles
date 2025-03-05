{ pkgs, ... }:
let
  username = "kelvin";
in
{
  imports = [
    # ./packages
  ];

  fonts.fontconfig.enable = true;

  xdg = {
    enable = true;
    userDirs = {
      enable = true;
      createDirectories = true;
    };
  };

  home = {
    username = "${username}";
    homeDirectory = "/home/${username}";
    stateVersion = "23.11";

    packages = with pkgs; [
      # w3m
      # dmenu
      android-tools
      bat
      brave
      bun
      cargo
      # celluloid
      chromium
      dbeaver
      discord
      deno
      dunst
      # efibootmgr
      # eww
      # feh
      fira-code-nerdfont
      # firefox
      firefox-devedition
      flameshot
      flatpak
      floorp
      flutter
      fontconfig
      freetype
      gcc
      # gimp
      gh
      git
      github-desktop
      gnome.gnome-keyring
      gnugrep
      gnumake
      go
      gparted
      # gnugrep
      # grub2
      # hyprland
      kitty
      libnotify
      lua
      luarocks
      # lxappearance
      mangohud
      meson
      neofetch
      neovim
      # nomacs
      # openssl
      # os-prober
      # nerdfonts
      nixpkgs-fmt
      nil
      nodejs
      nodePackages.pnpm
      obsidian
      oh-my-zsh
      ollama
      pavucontrol
      php
      picom
      # polkit_gnome
      powershell
      # protonup-ng
      python3Full
      python.pkgs.pip
      qemu
      ripgrep
      rofi-wayland
      spotify
      swww
      telegram-desktop
      # rofi
      # steam
      # steam-run
      # sxhkd
      # st
      # stdenv
      # synergy
      # swaycons
      starship
      supabase-cli
      terminus-nerdfont
      tldr
      # trash-cli
      unzip
      variety
      vscode
      waybar
      wpsoffice
      wofi
      wayland-protocols
      wayland-utils
      wl-clipboard
      wlroots
      xclip
      xdg-desktop-portal-gtk
      xdg-desktop-portal-hyprland
      xfce.thunar
      xorg.libX11
      xorg.libX11.dev
      xorg.libxcb
      xorg.libXft
      xorg.libXinerama
      xorg.xinit
      xorg.xinput
      xwayland
      yarn
      zoxide
      (lutris.override {
        extraPkgs = pkgs: [
          # List package dependencies here
          wineWowPackages.stable
          winetricks
        ];
      })
      zsh
      zsh-powerlevel10k
      zsh-autosuggestions
      zsh-syntax-highlighting
      zsh-completions
      zsh-history-substring-search
      zsh-nix-shell
    ];


  };
}
