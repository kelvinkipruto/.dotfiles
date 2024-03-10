{
  programs.zsh = {
    enable = true;
    enableCompletion = true;
    enableAutosuggestions = true;
    syntaxHighlighting.enable = true;

    shellAliases = {
      ll = "ls -l";
      update = "sudo nixos-rebuild switch";
    };
    history.size = 10000;

    # Oh my zsh setup
    oh-my-zsh = {
      enable = true;
      plugins = [ "git"];
      theme = "robbyrussell";
  };
  };
}