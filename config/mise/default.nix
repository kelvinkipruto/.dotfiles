{ config, lib, pkgs, ... }:
let
  homeDirectory = config.home.homeDirectory;
  rustupHome = "${homeDirectory}/.local/share/mise/rustup";
  cargoHome = "${homeDirectory}/.local/share/mise/cargo";
  tomlFormat = pkgs.formats.toml { };
  miseConfig = {
    # Backend preference: core shorthands, then vfox, then binary backends. Use asdf only as a fallback.
    tools = {
      node = "latest";
      bun = "latest";
      deno = "latest";
      go = "latest";
      python = "latest";
      java = "latest";
      dotnet = "latest";
      rust = "latest";
      "vfox:mise-plugins/vfox-flutter" = "latest";
      "vfox:mise-plugins/vfox-kotlin" = "latest";
      # vfox-dart currently errors on macOS arm64 with mise 2026.4.6.
      "asdf:mise-plugins/mise-dart" = "latest";
      "aqua:astral-sh/uv" = "latest";

      "npm:@openai/codex" = "latest";
      "npm:opencode-ai" = "latest";
      "npm:@qwen-code/qwen-code" = "latest";
      "npm:eas-cli" = "latest";
      "npm:@google/gemini-cli" = "latest";
    };

    env = {
      MISE_RUSTUP_HOME = rustupHome;
      MISE_CARGO_HOME = cargoHome;
      UV_PYTHON = {
        value = "{{ tools.python.path }}";
        tools = true;
      };
    };

    settings = {
      yes = true;
      all_compile = false;
    };
  };
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

  home.file.".config/mise/config.toml".source =
    tomlFormat.generate "mise-config.toml" miseConfig;

  home.activation.installMiseTools = lib.hm.dag.entryAfter [ "linkGeneration" ] ''
    echo "Installing mise-managed tools..."
    run ${pkgs.coreutils}/bin/env \
      HOME=${lib.escapeShellArg homeDirectory} \
      PATH=${lib.escapeShellArg activationPath} \
      MISE_YES=1 \
      MISE_ALL_COMPILE=false \
      MISE_RUBY_COMPILE=false \
      MISE_RUSTUP_HOME=${lib.escapeShellArg rustupHome} \
      MISE_CARGO_HOME=${lib.escapeShellArg cargoHome} \
      ${pkgs.mise}/bin/mise install --yes
    run ${pkgs.coreutils}/bin/env \
      HOME=${lib.escapeShellArg homeDirectory} \
      PATH=${lib.escapeShellArg activationPath} \
      MISE_YES=1 \
      MISE_RUSTUP_HOME=${lib.escapeShellArg rustupHome} \
      MISE_CARGO_HOME=${lib.escapeShellArg cargoHome} \
      ${pkgs.mise}/bin/mise reshim
  '';
}
