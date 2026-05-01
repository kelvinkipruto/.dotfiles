{ config, lib, pkgs, ... }:
let
  homeDirectory = config.home.homeDirectory;
  activationPath = lib.makeBinPath [
    pkgs.mise
    pkgs.coreutils
    pkgs.bash
    pkgs.curl
    pkgs.wget
    pkgs.gawk
    pkgs.gnugrep
    pkgs.gnused
    pkgs.gnutar
    pkgs.gzip
    pkgs.xz
    pkgs.unzip
    pkgs.git
    pkgs.findutils
    pkgs.which
  ];
in
{
  home.sessionPath = [
    "${homeDirectory}/.local/share/mise/shims"
  ];

  home.file.".config/mise/config.toml".text = ''
    [tools]
    node = "latest"
    bun = "latest"
    deno = "latest"
    go = "latest"
    python = "latest"
    ruby = "latest"
    java = "latest"
    dotnet = "latest"

    "npm:@openai/codex" = "latest"
    "npm:opencode-ai" = "latest"
    "npm:@qwen-code/qwen-code" = "latest"
    "npm:eas-cli" = "latest"

    [settings]
    yes = true
    all_compile = false
  '';

  home.activation.installMiseTools = lib.hm.dag.entryAfter [ "linkGeneration" ] ''
    echo "Installing mise-managed tools..."
    run ${pkgs.coreutils}/bin/env \
      HOME=${lib.escapeShellArg homeDirectory} \
      PATH=${lib.escapeShellArg activationPath} \
      MISE_YES=1 \
      MISE_ALL_COMPILE=false \
      MISE_RUBY_COMPILE=false \
      ${pkgs.mise}/bin/mise install --yes
    run ${pkgs.coreutils}/bin/env \
      HOME=${lib.escapeShellArg homeDirectory} \
      PATH=${lib.escapeShellArg activationPath} \
      MISE_YES=1 \
      ${pkgs.mise}/bin/mise reshim
  '';
}
