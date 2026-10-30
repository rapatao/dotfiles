{ lib, config, ... }:
(import ../group.nix { inherit lib config; } "web").homebrew {
  casks = [
    "google-chrome"
    "cloudflare-warp"
  ];
}
