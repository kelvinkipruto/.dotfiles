{ pkgs, ... }:
# Darwin (macOS) specific packages
[
  # macOS specific development tools
  pkgs.cocoapods
  pkgs.watchman
  pkgs.asdf-vm

  # macOS specific applications
  pkgs.raycast
  pkgs.rectangle
  pkgs.slack
  pkgs.localsend
]
