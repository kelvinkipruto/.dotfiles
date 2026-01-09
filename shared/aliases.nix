{
  shellAliases = {
    # File and directory operations
    cat = "bat --paging=never";
    ls = "eza --icons=always --color=always --group-directories-first";
    ll = "eza --icons=always --color=always --group-directories-first -l";
    la = "eza --icons=always --color=always --group-directories-first -la";
    lt = "eza --tree";

    # System maintenance
    clean = "nix-collect-garbage -d && sudo nix-collect-garbage -d";

    # Common shortcuts
    grep = "rg";
    find = "fd";
    top = "htop";
    reload = "source ~/.zshrc";
    cls = "clear";

    # Docker shortcuts
    dc = "docker-compose";
    dcu = "docker-compose up";
    dcd = "docker-compose down";
    dcb = "docker-compose build";

    # Nix shortcuts
    nix-search = "nix search nixpkgs";
    nix-shell = "nix-shell --run zsh";

    # Development
    serve = "python3 -m http.server";
    myip = "curl -s https://ipinfo.io/ip";

    # Tool shortcuts
    lg = "lazygit";

    # Zoxide shortcuts
    zi = "z -i"; # Interactive selection
    zq = "z -";
    zb = "z -b"; # Go back
  };
}
