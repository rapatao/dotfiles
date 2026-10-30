{ lib, config, ... }:
(import ../group.nix { inherit lib config; } "games").homebrew {
  casks = [
    "whisky"
    "heroic"
    "godot"
  ];
}
