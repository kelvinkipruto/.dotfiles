# TODO:

- [x] centralize-user-config: Create shared user configuration where username and home directory can be set in one place (priority: High)
- [x] remove-nodejs: Remove nodejs from packages since it will be managed by mise (priority: High)
- [x] move-cross-platform-packages: Move cross-platform packages (brave, chromium, firefox-devedition, kitty, cargo, etc.) to shared/packages/common.nix (priority: High)
- [x] update-stable-channel: Update flake.nix to use nixpkgs stable 25.05 and set ollama to use stable version (priority: High)
- [x] package-vs-programs: Review and prefer programs configuration over packages where available for better integration (priority: High)
- [x] enable-php-debug-global: Enable PHP debug across all systems, not just Darwin (priority: Medium)
- [x] share-environment-fonts: Share environment and font configs between Darwin and NixOS (priority: Medium)
- [x] configure-zsh-default: Set zsh as default shell across both systems with shared configuration (priority: Medium)
- [x] shared-program-configs: Configure alacritty, git, gh, gpg, tmux, vim, and neovim for reuse in shared/programs/ (priority: Medium)
- [ ] test-final-build: Test the final structure by building both Darwin and NixOS configurations (**IN PROGRESS**) (priority: Low)
