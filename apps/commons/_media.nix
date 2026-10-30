{ lib, config, pkgs, ... }:
(import ../group.nix { inherit lib config; } "media").packages [
  pkgs.ffmpeg
]
