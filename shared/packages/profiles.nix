{ pkgs, ... }:
let
  phpWithXdebug = pkgs.php.buildEnv {
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
  };
in
{
  common = {
    ai = [ ];

    php = [
      phpWithXdebug
    ];

    games = [
      pkgs.raylib
      pkgs.stockfish
    ];

    databases = [
      pkgs.duckdb
      pkgs.mariadb.client
      pkgs.mongodb-tools
      pkgs.redis
      pkgs.turso-cli
    ];

    media = [
      pkgs.ffmpeg
      pkgs.imagemagick
      pkgs.poppler
      pkgs.qpdf
      pkgs.resvg
      pkgs.yt-dlp
    ];

    androidSecurity = [
      pkgs.apktool
      pkgs.dex2jar
      pkgs.frida-tools
      pkgs.jadx
    ];

    mobile = [
      pkgs.android-tools
      pkgs.scrcpy
    ];

    workComms = [
      pkgs.slack-cli
    ];
  };

  darwin = {
    mobile = [
      pkgs.cocoapods
      pkgs.watchman
    ];
  };

  nixos = { };
}
