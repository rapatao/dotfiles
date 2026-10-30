{ lib, config, pkgs, ... }:
(import ../group.nix { inherit lib config; } "blog").packages [
  pkgs.hugo
  pkgs.imagemagick
]
