{ pkgs, ... }: {
  imports = [
    ../../config
  ];
  home = {
    stateVersion = "23.11";

    packages = with pkgs; [
      android-tools
      bat
      bun
      cargo
      discord
      # firefox-devedition
      fira-code-nerdfont
      flameshot
      flutter
      gleam
      lua
      luarocks
      neovim
      nerdfonts
      nixpkgs-fmt
      obsidian
      ollama
      python3Full
      volta
      zip
    ];
  };

  programs = {
    home-manager = {
      enable = true;
    };
  };
}
