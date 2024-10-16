{ self, pkgs, ... }:
{
  environment = {
    systemPackages = with pkgs; [
      git
      neofetch
      vim
      zsh
    ];
    variables = {
      EDITOR = "nvim";
      VISUAL = "nvim";
    };

  };
}
