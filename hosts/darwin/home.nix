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
    ".p10k.zsh".source = ../../config/zsh/p10k.zsh;
  };
}
