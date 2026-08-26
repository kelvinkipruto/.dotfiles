{ lib, ... }:
{
  imports = [
    ../../shared/home-manager
    ../../config
  ];

  home.sessionPath = [
    "$HOME/.orbstack/bin"
  ];

  home.packages = lib.mkAfter [
    # Darwin-specific packages go here.
  ];

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
