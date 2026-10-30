{ lib, config, ... }:
(import ../group.nix { inherit lib config; } "developer").homebrew {
  taps = [
    "akitaonrails/tap"
  ];
  casks = [
    "jetbrains-toolbox"
    "visual-studio-code"
    "docker-desktop"
  ];
  brews = [
    "rtk"
    "akitaonrails/tap/ai-memory"
  ];
}
