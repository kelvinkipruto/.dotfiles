{ pkgs, ... }: {

  imports = [
    ./hardware-configuration.nix
    ./wayland.nix
  ];

  documentation.nixos.enable = false;

  nix = {
    settings = {
      warn-dirty = false;
      experimental-features = "nix-command flakes";
      auto-optimise-store = true;
    };
  };

  nixpkgs = {
    config = {
      allowUnfree = true;

      permittedInsecurePackages = [
        "openssl-1.1.1w"
        "python-2.7.18.7"
      ];
    };
    overlays = [
      (self: super: {
        waybar = super.waybar.overrideAttrs (oldAttrs: {
          mesonFlags = oldAttrs.mesonFlags ++ [ "-Dexperimental=true" ];
        });
      })
    ];
  };

  hardware = {
    graphics = {
      enable = true;
      enable32Bit = true;
    };

    nvidia = {
      modesetting = {
        enable = true;
      };
    };
  };


  boot = {
    tmp.cleanOnBoot = true;
    # supportedFilesystems = ["ntfs"];
    loader = {
      efi.canTouchEfiVariables = true;
      systemd-boot.enable = true;
      # grub = {
      #   device = "nodev";
      #   efiSupport = true;
      #   enable = true;
      #   useOSProber = true;
      #   timeoutStyle = "menu";
      # };
      # timeout = 300;
    };

    kernelModules = [ "kvm-intel" "vfio-pci" ];
    kernelParams = [ "nohibernate" "intel_iommu=on" "iommu=pt" ];

    # kernel.sysctl = {
    #   "net.ipv4.tcp_congestion_control" = "bbr";
    #   "net.core.default_qdisc" = "fq";
    #   "net.core.wmem_max" = 1073741824;
    #   "net.core.rmem_max" = 1073741824;
    #   "net.ipv4.tcp_rmem" = "4096 87380 1073741824";
    #   "net.ipv4.tcp_wmem" = "4096 87380 1073741824";
    # };
  };

  networking = {
    hostName = "nixos";
    networkmanager = {
      enable = true;
    };
    enableIPv6 = false;
    firewall = {
      enable = true;
    };
    # interfaces = {
    #   br0 = {
    #     useDHCP = true;
    #   };
    # };
    # bridges = {
    #   br0 = {
    #     interfaces = ["enp0s25"];
    #     priority = 100;
    #   };
    # };
  };

  time.timeZone = "Africa/Nairobi";

  i18n.defaultLocale = "en_GB.UTF-8";
  console = {
    packages = [ pkgs.nerd-fonts.terminess-ttf ];
    font = "${pkgs.nerd-fonts.terminess-ttf}/share/consolefonts/ter-i22b.psf.gz";
    useXkbConfig = true;
  };

  services = {
    flatpak.enable = true;
    dbus.enable = true;
    picom.enable = true;

    displayManager = {
      sddm = {
        enable = true;
        enableHidpi = true;
      };
      defaultSession = "hyprland";
      # lightdm.enable = true;
      # setupCommands = ''
      #   ${pkgs.xorg.xrandr}/bin/xrandr --output DP-1 --off --output DP-2 --off --output DP-3 --off --output HDMI-1 --mode 1920x1080 --pos 0x0 --rotate normal
      # '';
      # autoLogin = {
      #   enable = true;
      #   user = "kelvin";
      # };
    };

    xserver = {
      enable = true;
      # windowManager.dwm.enable = true;
      xkb = {
        layout = "us";
        variant = "";
      };
    };

    desktopManager = {
      plasma6 = {
        enable = true;
      };
      # default = "hyprland";
    };

    printing.enable = true;

    pulseaudio = {
      enable = false;
      support32Bit = true;
    };

    pipewire = {
      enable = true;
      alsa.enable = true;
      alsa.support32Bit = true;
      pulse.enable = true;
      jack.enable = true;
    };
  };

  # nixpkgs.overlays = [
  #   (final: prev: {
  #     dwm = prev.dwm.overrideAttrs (old: {src = /home/${user}/CTT-Nix/system/dwm-titus;}); #FIX ME: Update with path to your dwm folder
  #   })
  # ];
  # programs.zsh.enable = true;
  programs = {
    zsh = {
      enable = true;
    };
    # hyprland = {
    #   enable = true;
    #   xwayland = {
    #     enable = true;
    #   };
    # };
  };
  users.defaultUserShell = pkgs.zsh;

  users.users.kelvinkipruto = {
    isNormalUser = true;
    description = "Kelvin Kipruto";
    shell = pkgs.zsh;
    extraGroups = [
      "flatpak"
      "disk"
      "docker"
      "qemu"
      "kvm"
      "libvirtd"
      "sshd"
      "networkmanager"
      "wheel"
      "audio"
      "video"
      "libvirtd"
      "root"
    ];
  };

  # programs.steam = {
  #   enable = true;
  #   remotePlay.openFirewall = true; # Open ports in the firewall for Steam Remote Play
  #   dedicatedServer.openFirewall = true; # Open ports in the firewall for Source Dedicated Server
  # };

  fonts = {
    packages = with pkgs; [
      noto-fonts
      noto-fonts-cjk-sans
      noto-fonts-emoji
      font-awesome
      source-han-sans
      source-han-sans-japanese
      source-han-serif-japanese
      # (nerdfonts.override { fonts = [ "Meslo" ]; })
    ];
    fontconfig = {
      enable = true;
      defaultFonts = {
        monospace = [ "Meslo LG M Regular Nerd Font Complete Mono" ];
        serif = [ "Noto Serif" "Source Han Serif" ];
        sansSerif = [ "Noto Sans" "Source Han Sans" ];
      };
    };
  };

  environment = {
    systemPackages = with pkgs; [
      vim
      wget
      docker
      firefox
      # dunst
      # hyprland
      # kitty
      # libnotify
      libvirt
      # meson
      networkmanagerapplet
      # rofi-wayland
      # swww
      virt-manager
      # waybar
      # xdg-desktop-portal-gtk
      # xdg-desktop-portal-hyprland
      # wofi
      # xwayland
      # wayland-protocols
      # wayland-utils
      # wl-clipboard
      # wlroots
      # (waybar.overrideAttrs (old: {
      #   mesonFlags = old.mesonFlags or [] ++ ["-Dexperimental=true"];
      # }))

      # PHP with global debugging enabled
      (php.buildEnv {
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
      })
    ];
    # sessionVariables = {
    #   NIXOS_OZONE_WL = "1";
    #   WLR_NO_HARDWARE_CURSORS = "1";
    #   MOZ_ENABLE_WAYLAND = "1";
    #   MOZ_WEBRENDER = "1";
    # };
  };

  # virtualisation.libvirtd.enable = true;
  # virtualisation.docker.enable = true;
  # virtualisation.docker.enableOnBoot = true;
  virtualisation = {
    libvirtd = {
      enable = true;
      qemu = {
        swtpm = {
          enable = true;
        };
      };
    };
    docker = {
      enable = true;
      enableOnBoot = true;
    };
  };

  xdg.portal = {
    enable = true;
    wlr.enable = true;
    config.common.default = "*";
    extraPortals = [ pkgs.xdg-desktop-portal-gtk ];
  };

  # security.polkit.enable = true;
  security.rtkit.enable = true;

  # systemd = {
  #   user.services.polkit-gnome-authentication-agent-1 = {
  #     description = "polkit-gnome-authentication-agent-1";
  #     wantedBy = ["graphical-session.target"];
  #     wants = ["graphical-session.target"];
  #     after = ["graphical-session.target"];
  #     serviceConfig = {
  #       Type = "simple";
  #       ExecStart = "${pkgs.polkit_gnome}/libexec/polkit-gnome-authentication-agent-1";
  #       Restart = "on-failure";
  #       RestartSec = 1;
  #       TimeoutStopSec = 10;
  #     };
  #   };
  # };

  system.stateVersion = "23.11";
  system.autoUpgrade.enable = true;
  system.autoUpgrade.allowReboot = true;
}
