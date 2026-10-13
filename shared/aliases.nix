{
  shellAliases = {
    # File and directory operations
    cat = "bat --paging=never";
    ls = "eza --icons=always --color=always --group-directories-first";
    ll = "eza --icons=always --color=always --group-directories-first -l";
    la = "eza --icons=always --color=always --group-directories-first -la";
    lt = "eza --tree";

    # System maintenance
    clean = "just --justfile ~/.dotfiles/justfile clean";
    maintain = "just --justfile ~/.dotfiles/justfile maintain";
    sys-build = "just --justfile ~/.dotfiles/justfile build";
    sys-switch = "just --justfile ~/.dotfiles/justfile switch";

    # Common shortcuts
    grep = "rg";
    find = "fd";
    top = "htop";
    reload = "source ~/.zshrc";
    cls = "clear";

    # Docker shortcuts
    dc = "docker compose";
    dcu = "docker compose up";
    dcd = "docker compose down";
    dcb = "docker compose build";
    dcub = "docker compose up --build";
    dcr = "docker compose run";
    dcl = "docker compose logs";
    dcp = "docker compose ps";
    dce = "docker compose exec";
    dct = "docker compose top";
    dcs = "docker compose stop";
    dcrun = "docker compose run --rm";

    # Nix shortcuts
    nix-search = "nix search nixpkgs";
    nix-shell = "nix-shell --run zsh";
    brew-maintain = "just --justfile ~/.dotfiles/justfile maintain-brew";
    nix-audit = "just --justfile ~/.dotfiles/justfile audit-nix";
    nix-maintain = "just --justfile ~/.dotfiles/justfile maintain-nix";
    nix-optimise = "just --justfile ~/.dotfiles/justfile optimise-nix";

    # Development
    serve = "python3 -m http.server";
    myip = "curl -s https://ipinfo.io/ip";

    # Tool shortcuts
    lg = "lazygit";
    kp = "killport";

    # Zoxide shortcuts
    zi = "z -i"; # Interactive selection
    zq = "z -";
    zb = "z -b"; # Go back
  };
}
