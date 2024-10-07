{ inputs, pkgs, self, ... }: {
  imports = [
    ./gh
    ./git
    # ./gpg
    ./zsh
  ];
}
