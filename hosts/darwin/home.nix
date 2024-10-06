{ pkgs, ... }: {
  #     imports = [
  #     ../../configs
  #   ];
  home = {
    stateVersion = "23.11";

    packages = with pkgs; [
      zip
      spotify
    ];
  };

  programs = {
    home-manager = {
      enable = true;
    };
  };
}
