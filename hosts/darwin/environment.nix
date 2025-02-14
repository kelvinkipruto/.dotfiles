{ self, pkgs, ... }:
{
  environment = {
    systemPackages = with pkgs; [
      git
      neofetch
      vim
      zsh
      (php.buildEnv {
        extensions = ({enabled, all}: enabled ++ (with all; [
          grpc
          xdebug
        ]));
        extraConfig = ''
          xdebug.mode = debug
        '';
      })
    ];
    variables = {
      EDITOR = "nvim";
      VISUAL = "nvim";
    };

  };
}
