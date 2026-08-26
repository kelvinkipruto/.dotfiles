{ config, lib, pkgs, ... }:
let
  homeDirectory = config.home.homeDirectory;
  rustupHome = "${homeDirectory}/.local/share/mise/rustup";
  cargoHome = "${homeDirectory}/.local/share/mise/cargo";
  pythonHome = "${homeDirectory}/.local/share/mise/installs/python/latest";
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
      "core:dotnet" = "latest";
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

      #herdr
      "github:ogulcancelik/herdr" = "latest";
    };

    env = {
      MISE_RUSTUP_HOME = rustupHome;
      MISE_CARGO_HOME = cargoHome;
      UV_PYTHON = "${pythonHome}/bin/python";
    };

    settings = {
      yes = true;
      all_compile = false;
    };
  };

  # Platform split for mise binary:
  #   Darwin:  mise is installed via Homebrew (bottle).  Activation runs with a
  #            minimal PATH that does not include Homebrew's prefix, so we must
  #            inject the two standard macOS Homebrew locations (Apple Silicon
  #            and Intel) explicitly.
  #   NixOS:   mise comes from nixpkgs, so reference the store path directly.
  activationInputs = [
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
  ] ++ lib.optionals pkgs.stdenv.isLinux [ pkgs.mise ];

  activationBinPath = lib.makeBinPath activationInputs;

  # Standard Homebrew prefixes on macOS.  One of these will exist on any
  # supported install; prepending both is harmless.
  darwinHomebrewBinPaths = "/opt/homebrew/bin:/opt/homebrew/sbin:/usr/local/bin:/usr/local/sbin";

  # Compute the PATH and mise command for the CURRENT host only.
  # Since these values differ by host (Darwin vs NixOS) we only ever evaluate the right branch.
  activationPathForThisHost =
    if pkgs.stdenv.isLinux
    then activationBinPath
    else "${activationBinPath}:${darwinHomebrewBinPaths}";

  miseCmd = if pkgs.stdenv.isLinux then "${pkgs.mise}/bin/mise" else "mise";

  # Single, host-specific bash script.  Two fully-written branches so there is
  # ZERO Nix string `+` concatenation inside bash blocks — this is what caused
  # the "unexpected token `fi'" bash parse error.
  miseActivationBash =
    if pkgs.stdenv.isDarwin
    then ''
      set -euo pipefail
      export HOME=${lib.escapeShellArg homeDirectory}
      export PATH=${lib.escapeShellArg activationPathForThisHost}
      export MISE_YES=1
      export MISE_ALL_COMPILE=false
      export MISE_RUBY_COMPILE=false
      export MISE_RUSTUP_HOME=${lib.escapeShellArg rustupHome}
      export MISE_CARGO_HOME=${lib.escapeShellArg cargoHome}
      export RUSTUP_HOME=${lib.escapeShellArg rustupHome}
      export CARGO_HOME=${lib.escapeShellArg cargoHome}

      if ! ${pkgs.which}/bin/which mise >/dev/null 2>&1; then
        echo "ERROR: mise binary not found during activation."
        echo "  Activation PATH=$PATH"
        echo "  Try: brew install mise"
        echo "  Expected locations: /opt/homebrew/bin/mise or /usr/local/bin/mise"
        exit 1
      fi

      echo "  Using mise at: $(${pkgs.which}/bin/which mise)"
      ${miseCmd} install --yes
      ${miseCmd} reshim
    ''
    else ''
      set -euo pipefail
      export HOME=${lib.escapeShellArg homeDirectory}
      export PATH=${lib.escapeShellArg activationPathForThisHost}
      export MISE_YES=1
      export MISE_ALL_COMPILE=false
      export MISE_RUBY_COMPILE=false
      export MISE_RUSTUP_HOME=${lib.escapeShellArg rustupHome}
      export MISE_CARGO_HOME=${lib.escapeShellArg cargoHome}
      export RUSTUP_HOME=${lib.escapeShellArg rustupHome}
      export CARGO_HOME=${lib.escapeShellArg cargoHome}

      if ! ${pkgs.which}/bin/which mise >/dev/null 2>&1; then
        echo "ERROR: mise binary not found during activation."
        echo "  Activation PATH=$PATH"
        echo "  Expected mise in the Nix store (pkgs.mise)"
        exit 1
      fi

      echo "  Using mise at: $(${pkgs.which}/bin/which mise)"
      ${miseCmd} install --yes
      ${miseCmd} reshim
    '';
in
{
  home.sessionPath = [
    "${homeDirectory}/.local/share/mise/shims"
  ];

  home.sessionVariables = {
    MISE_RUSTUP_HOME = rustupHome;
    MISE_CARGO_HOME = cargoHome;
    RUSTUP_HOME = rustupHome;
    CARGO_HOME = cargoHome;
  };

  home.file.".config/mise/config.toml".source =
    tomlFormat.generate "mise-config.toml" miseConfig;

  home.activation.installMiseTools = lib.hm.dag.entryAfter [ "linkGeneration" ] ''
    echo "Installing mise-managed tools..."
    run ${pkgs.bash}/bin/bash -c ${lib.escapeShellArg miseActivationBash}
  '';
}
