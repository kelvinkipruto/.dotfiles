{ self, ... }:
{
  services = {
    nix-daemon = {
      enable = true;
    };
  };
}
