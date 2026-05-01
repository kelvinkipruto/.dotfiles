{ ... }:
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
    PATH = "$HOME/.local/bin:$HOME/go/bin:$PATH";
  };
}
