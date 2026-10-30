{ lib, config, ... }:
(import ../group.nix { inherit lib config; } "social").homebrew {
  casks = [
    "discord"
    "slack"
  ];
}
