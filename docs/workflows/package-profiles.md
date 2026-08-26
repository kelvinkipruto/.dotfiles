Package Profiles

Goal
- Keep the default system useful without carrying every language, security, media, or mobile tool all the time.
- Put tools that are heavy, niche, or occasionally fragile behind explicit profile flags.
- Keep core daily tools in the always-on package sets.

Where profiles live
- `shared/package-profiles.nix` contains the global defaults.
- `shared/packages/profiles.nix` maps each profile to packages.
- `shared/packages/default.nix` combines always-on packages with enabled profiles for Darwin and NixOS.

Current defaults

| Profile | Default | Contents |
| --- | --- | --- |
| `ai` | on | No packages currently assigned |
| `php` | on | PHP with `grpc` and `xdebug` extensions |
| `games` | on | `stockfish`, `raylib` |
| `databases` | on | `duckdb`, `redis`, `mongodb-tools`, `turso-cli` |
| `media` | off | `ffmpeg`, `yt-dlp`, `imagemagick`, `poppler`, `resvg`, `qpdf` |
| `androidSecurity` | off | `apktool`, `dex2jar`, `frida-tools`, `jadx` |
| `mobile` | off | `android-tools`, `scrcpy`; plus `cocoapods` and `watchman` on Darwin |
| `workComms` | off | `slack-cli` |

Always-on by design
- Docker tooling stays always-on for Linux because local containers are core workflow dependencies.
- Network tools stay always-on: `cloudflared`, `ngrok`, `httrack`, `nmap`, `dnsmasq`, `mkcert`.
- Archive basics stay always-on: `zip`, `unzip`, `unrar`.
- Flutter and Dart stay managed by mise, not Nix.
- Rust, Python, Node, Deno, Go, Java, Kotlin, Dotnet, uv, and similar versioned language runtimes should stay in mise unless there is a specific reason to pin them through Nix.

Changing a profile

Edit `shared/package-profiles.nix`:

```nix
{
  androidSecurity = true;
  mobile = true;
}
```

Then validate and apply:

```bash
just build
just switch
```

Auditing profile impact

```bash
# Show largest paths in the current system closure
just audit-closure

# Explain why a package is in the current system closure
just why-depends raylib
just why-depends nixpkgs#ffmpeg
```

Operational notes
- Prefer adding new optional tools to `shared/packages/profiles.nix` before adding them to always-on package lists.
- Keep a profile default-on only when the tools are used frequently or provide core system behavior.
- Keep default-off profiles buildable. They may be disabled day to day, but they should not become stale.
