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

Dotnet is pinned to the explicit `core:dotnet` backend so an old user plugin cannot override mise's core backend.

Avoid globally unless a current project needs them:

- Ruby
- Gleam
- OCaml/opam
- Elixir/Erlang
- Lua/LuaRocks

Prefer project-local `.mise.toml` files for rare toolchains. That keeps login shells light and avoids installing large SDKs globally.

## Current Cleanup Notes

Old installs pruned on 2026-05-01:

- older Node versions: `22.21.1`, `22.22.2`, `24.5.0`
- older Bun versions: `1.2.20`, `1.2.21`
- unused runtimes: Ruby, Gleam, OCaml/opam
- old shorthand Kotlin install; Kotlin is now managed through `vfox:mise-plugins/vfox-kotlin`
- obsolete `npm:codex`; Codex is now managed as `npm:@openai/codex`
- manual Rust state in `~/.rustup` and `~/.cargo`
- stale manual `~/.local/bin/mise`; mise is now managed through Nix/Home Manager

Rust is now installed through mise under:

- `~/.local/share/mise/rustup`
- `~/.local/share/mise/cargo`

Core dotnet stores the SDK under `~/.local/share/mise/dotnet-root`; `~/.local/share/mise/installs/dotnet` is mostly symlink metadata.

`UV_PYTHON` points at `~/.local/share/mise/installs/python/latest/bin/python` so uv uses the mise-managed Python interpreter without relying on a mise template that can break non-install commands.

After a successful switch, verify:

```sh
which rustc
which cargo
rustc --version
cargo --version
```

They should resolve through mise shims or the mise-managed cargo path. If a stale shell still has `RUSTUP_HOME`, `CARGO_HOME`, or `RUSTUP_TOOLCHAIN` pointing at the old locations, open a fresh shell after `just switch-darwin`.

Do not run blanket `mise prune` without inspecting it first. Backend-prefixed tools can appear twice in `mise list`, and `mise ls --prunable` may report active backend install directories such as the vfox/asdf Dart, Flutter, or Kotlin installs. Prefer explicit cleanup:

```sh
mise ls --prunable
mise uninstall node@22.21.1
```

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

`switch-darwin` runs `sudo -H darwin-rebuild switch --flake .#kelvinkipruto` because nix-darwin system activation now runs as `root`. `-H` resets HOME to /var/root so Nix doesn't warn that $HOME isn't owned by the effective UID.
