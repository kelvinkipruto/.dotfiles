{ lib, pkgs, ... }:
{
  imports = [
    ../../shared/home-manager
    ../../config
  ];

  home.packages = lib.mkAfter (with pkgs; [
    # Darwin-specific packages go here.
  ]);

  home.file = {
    ".local/bin/brave" = {
      executable = true;
      text = ''
        #!/bin/sh
        exec open -a "Brave Browser" "$@"
      '';
    };
    ".p10k.zsh".source = ../../config/zsh/p10k.zsh;
  };
}
