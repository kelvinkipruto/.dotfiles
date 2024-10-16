{ self, pkgs, user, ... }:
{
  users.users.kelvinkipruto = {
    name = ${user};
    home = "/Users/kelvinkipruto";
  };
}
