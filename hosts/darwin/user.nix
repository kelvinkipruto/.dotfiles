{ self, pkgs, user, ... }:
{
  users.users.${user} = {
    name = user;
    home = "/Users/kelvinkipruto";
  };
}
