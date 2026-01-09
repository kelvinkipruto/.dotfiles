{ self, pkgs, userConfig, ... }:
{
  users.users.${userConfig.name} = {
    name = userConfig.name;
    home = "/Users/${userConfig.name}";
    shell = pkgs.zsh;
  };
}
