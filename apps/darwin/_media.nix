{ lib, config, ... }:
(import ../group.nix { inherit lib config; } "media").homebrew {
  casks = [
    "vlc"
    "stremio"
  ];
}
