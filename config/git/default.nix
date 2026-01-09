{ userConfig, ... }:
{
  programs.git = {
    enable = true;
    lfs.enable = true;
    settings = {
      init.defaultBranch = "main";
      pull.rebase = true;
      user = {
        name = userConfig.name;
        email = userConfig.email;
      };
      delta = {
        enable = true;
        enableGitIntegration = true;
        options = {
          features = "side-by-side";
        };
      };

      aliases = {
        br = "branch";
        co = "checkout";
        st = "status";
        iac = "!git init && git add . && git commit -m 'Init'";
        cm = "commit -m";
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
        pl = "pull";
        ps = "push";
      };
    };
  };
}
