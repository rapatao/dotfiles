{ lib, config, ... }:
let cfg = config.apps; in {
  options = {
    apps.blog = lib.mkEnableOption "Install blog development tools";
    apps.devops = lib.mkEnableOption "Install devops tools";
    apps.developer = lib.mkEnableOption "Install development tools";
    apps.games = lib.mkEnableOption "Install gaming tools";
    apps.media = lib.mkEnableOption "Install media tools";
    apps.social = lib.mkEnableOption "Install social media tools";
  };

  imports = [
    ./_blog.nix
    ./_core.nix
    ./_developer.nix
    ./_devops.nix
    ./_games.nix
    ./_media.nix
    ./_social.nix
  ];
}
