{ lib, config, ... }:
(import ../group.nix { inherit lib config; } "core").homebrew {
  taps = [
    { name = "rapatao/tap"; trusted = true; }
  ];
  brews = [
    "mas"
  ];
  casks = [
    "ghostty"
    "rectangle"
    "caffeine"
    "alfred"
    "mounty"
    "openlogi"
    "virtual-display"
    "puremac"
  ];
}
