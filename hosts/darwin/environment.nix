{ self, pkgs, ... }:
{
  environment = {
    systemPackages = with pkgs; [
      neofetch
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
    # Environment variables are now handled by shared configuration
  };
}
