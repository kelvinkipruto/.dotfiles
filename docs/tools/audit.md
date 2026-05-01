# Tool Audit

This repo uses a small ownership policy:

- Nix manages system packages, GUI apps available through Nix, and stable CLI utilities.
- Home Manager `programs.*` manages tools with first-class modules.
- mise manages version-sensitive runtimes and CLI tools where project versions matter.
- Homebrew is reserved for macOS-only packages or packages that are better maintained there.
- Manual installs should be temporary and documented until they move into Nix, Homebrew, or mise.

## Global Mise Tools

Keep globally:

- JavaScript runtimes: Node, Bun, Deno
- Python: Python and uv
- Go
- Rust
- JVM/mobile: Java, Kotlin, Flutter, Dart
- Sometimes-used app runtimes: dotnet
- AI and mobile CLIs: Codex, OpenCode, Qwen, Gemini, EAS

Avoid globally unless a current project needs them:

- Ruby
- Gleam
- OCaml/opam
- Elixir/Erlang
- Lua/LuaRocks

Prefer project-local `.mise.toml` files for rare toolchains. That keeps login shells light and avoids installing large SDKs globally.

## Current Cleanup Notes

Rust was previously installed manually through rustup:

- `~/.rustup`
- `~/.cargo`

The repo now removes `~/.cargo/bin` from the managed `PATH` and configures mise Rust state under:

- `~/.local/share/mise/rustup`
- `~/.local/share/mise/cargo`

After a successful switch, verify:

```sh
which rustc
which cargo
rustc --version
cargo --version
```

If they resolve through mise and Rust works, the old manual install can be archived or deleted.

## Audit Commands

Run:

```sh
just audit-tools
```

Build checks:

```sh
just check-darwin
just build-darwin
```

Apply macOS config:

```sh
just switch-darwin
```

`switch-darwin` runs `sudo darwin-rebuild switch --flake .#kelvinkipruto` because nix-darwin system activation now runs as `root`.
