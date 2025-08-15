{ inputs, pkgs, self, ... }: {
  imports = [
    ./gh
    ./git
    # ./gpg
    ./zsh
    ./alacritty
    ./kitty
    ./tmux
    ./yazi
  ];
}
