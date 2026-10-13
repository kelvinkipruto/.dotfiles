Git Hooks

Purpose
- Run `nix flake check` and lint before each commit.

Install
- scripts/install-git-hooks.sh

Skip once
- SKIP_NIX_CHECK=1 git commit -m "msg"

Notes
- Hooks are local to your clone via core.hooksPath.
- Lint uses `statix check` and `deadnix`.
