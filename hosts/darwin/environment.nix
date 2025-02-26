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
          xdebug.remote_enable = true
          xdebug.remote_host = 127.0.0.1
          xdebug.remote_port = 9000
        '';
      })
    ];
    variables = {
      EDITOR = "nvim";
      VISUAL = "nvim";
    };

  };
}
