{pkgs, user, ...}: {
  
  imports = [
    ./hardware-configuration.nix
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
  };

  hardware.opengl.driSupport32Bit = true;
  hardware.pulseaudio.enable = false;
  hardware.pulseaudio.support32Bit = true;

  boot = {
    kernelParams = ["nohibernate"];
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

    # kernelModules = ["tcp_bbr"];
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
    networkmanager.enable = true;
    enableIPv6 = false;
    firewall.enable = false;
  };

  time.timeZone = "Africa/Nairobi";

  i18n.defaultLocale = "en_US.UTF-8";
  console = {
    packages = [pkgs.terminus_font];
    font = "${pkgs.terminus_font}/share/consolefonts/ter-i22b.psf.gz";
    useXkbConfig = true;
  };

  sound.enable = true;


  services = {
    flatpak.enable = true;
    dbus.enable = true;
    picom.enable = true;

    xserver = {
      enable = true;
      # windowManager.dwm.enable = true;
      xkb = {
        layout = "us";
        variant = "";
      };

      displayManager = {
        sddm.enable = true;
        # lightdm.enable = true;
        # setupCommands = ''
        #   ${pkgs.xorg.xrandr}/bin/xrandr --output DP-1 --off --output DP-2 --off --output DP-3 --off --output HDMI-1 --mode 1920x1080 --pos 0x0 --rotate normal
        # '';
        # autoLogin = {
        #   enable = true;
        #   user = "kelvin";
        # };
      };

      desktopManager = {
        plasma5.enable = true;
      };
    };

    printing.enable = true;

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

  users.users.kelvin = {
    isNormalUser = true;
    description = "Kelvin Kipruto";
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
      noto-fonts-cjk
      noto-fonts-emoji
      font-awesome
      source-han-sans
      source-han-sans-japanese
      source-han-serif-japanese
      (nerdfonts.override {fonts = ["Meslo"];})
    ];
    fontconfig = {
      enable = true;
      defaultFonts = {
        monospace = ["Meslo LG M Regular Nerd Font Complete Mono"];
        serif = ["Noto Serif" "Source Han Serif"];
        sansSerif = ["Noto Sans" "Source Han Sans"];
      };
    };
  };

  environment.systemPackages = with pkgs; [
    vim
    docker
  ];

  virtualisation.libvirtd.enable = true;
  virtualisation.docker.enable = true;
  virtualisation.docker.enableOnBoot = true;

  # xdg.portal = {
  #   enable = true;
  #   config.common.default = "*";
  #   extraPortals = [pkgs.xdg-desktop-portal-gtk];
  # };

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