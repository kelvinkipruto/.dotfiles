{
  programs.git = {
    enable = true;
    # TODO: Pass the user name and email as arguments
    userName = "kelvinkipruto";
    userEmail = "hello@kipruto.dev";
    lfs.enable = true;

    extraConfig = {
      init.defaultBranch = "main";
      pull.rebase = true;
    };

    delta = {
      enable = true;
      options = {
        features = "side-by-side";
      };
    };

    aliases = {
      br = "branch";
      co = "checkout";
      st = "status";
      cm = "commit";
      ca = "commit --amend";
      unstage = "reset HEAD --";
      ls = "log --pretty=format:\"%C(yellow)%h%Cred%d\\\\ %Creset%s%Cblue\\\\ [%cn]\" --decorate";
      ll = "log --pretty=format:\"%C(yellow)%h%Cred%d\\\\ %Creset%s%Cblue\\\\ [%cn]\" --decorate --numstat";
      dc = "diff --cached";
      d = "diff";
      amend = "commit --amend --no-edit";
      uncommit = "reset --soft HEAD^";
      undo = "checkout --";
      cp = "cherry-pick";
      rb = "rebase";
      rbc = "rebase --continue";
      rba = "rebase --abort";
      m = "merge";
      ma = "merge --abort";
    };

  };
}
