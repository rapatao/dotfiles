{ lib, config, ... }:
(import ../group.nix { inherit lib config; } "devops").homebrew {
  taps = [
    "infisical/get-cli"
  ];
  brews = [
    "infisical/get-cli/infisical"
  ];
}
