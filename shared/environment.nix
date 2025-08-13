{ pkgs, ... }:
# Shared environment configurations for both Darwin and NixOS
{
  # Environment variables
  sessionVariables = {
    EDITOR = "nvim";
    BROWSER = "brave";
    TERMINAL = "alacritty";
    PAGER = "less";
    MANPAGER = "less";

    # Development
    LANG = "en_US.UTF-8";
    LC_ALL = "en_US.UTF-8";

    # PHP debugging
    XDEBUG_MODE = "debug";
    XDEBUG_START_WITH_REQUEST = "yes";
    XDEBUG_CLIENT_PORT = "9003";
    XDEBUG_CLIENT_HOST = "127.0.0.1";

    # Path additions
    PATH = "$HOME/.local/bin:$HOME/.cargo/bin:$HOME/go/bin:$PATH";
  };

  # Shell aliases (can be imported by shell configurations)
  shellAliases = {
    # File operations
    ll = "eza -la";
    la = "eza -la";
    ls = "eza";
    cat = "bat";
    cd = "z";

    # Git shortcuts
    g = "git";
    gs = "git status";
    ga = "git add";
    gc = "git commit";
    gp = "git push";
    gl = "git pull";
    gd = "git diff";

    # System shortcuts
    reload = "source ~/.zshrc";
    cls = "clear";

    # Development
    serve = "python3 -m http.server";
    myip = "curl -s https://ipinfo.io/ip";
  };
}
