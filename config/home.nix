{pkgs, ...}: let
  username = "kelvin";
in {
  imports = [
    ./packages
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
      vim
      wget
      # w3m
      # dmenu
      # neofetch
      # neovim
      # starship
      # bat
      brave
      # cargo
      # celluloid
      chromium
      # dunst
      efibootmgr
      # eww
      # feh
      # flameshot
      # flatpak
      floorp
      fontconfig
      freetype
      gcc
      # gimp
      git
      # github-desktop
      gnome.gnome-keyring
      gnugrep
      gnumake
      # gparted
      # gnugrep
      # grub2
      # kitty
      # luarocks
      # lxappearance
      # mangohud
      # neovim
      # nomacs
      # openssl
      # os-prober
      nerdfonts
      pavucontrol
      picom
      # polkit_gnome
      # powershell
      # protonup-ng
      python3Full
      python.pkgs.pip
      qemu
      ripgrep
      # rofi
      # steam
      # steam-run
      # sxhkd
      # st
      # stdenv
      # synergy
      # swaycons
      terminus-nerdfont
      # tldr
      # trash-cli
      unzip
      # variety
      virt-manager
      # xclip
      # xdg-desktop-portal-gtk
      xfce.thunar
      # xorg.libX11
      # xorg.libX11.dev
      # xorg.libxcb
      # xorg.libXft
      # xorg.libXinerama
      # xorg.xinit
      # xorg.xinput
      # zoxide
      # (lutris.override {
      #   extraPkgs = pkgs: [
      #     # List package dependencies here
      #     wineWowPackages.stable
      #     winetricks
      #   ];
      # })
    ];
  };
}