{ pkgs, ... }:
# Darwin (macOS) specific packages
[
  # macOS specific development tools
  # Firefox's Homebrew cask currently fails under pinned brew bundle parsing.
  pkgs.firefox-bin
  pkgs.firefox-devedition
  pkgs.asdf-vm
]
