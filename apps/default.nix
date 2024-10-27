{ lib, config, ... }:
let cfg = config.apps; in {
  options = {
    apps.blog = lib.mkEnableOption "Install blog development tools";
    apps.cloud = lib.mkEnableOption "Install cloud managemenent tools";
    apps.developer = lib.mkEnableOption "Install development tools";
    apps.games = lib.mkEnableOption "Install gaming tools";
    apps.kubernetes = lib.mkEnableOption "Install kubernetes management tools";
    apps.media = lib.mkEnableOption "Install media tools";
    apps.social = lib.mkEnableOption "Install social media tools";
  };

  imports = [
    ./_blog.nix
    ./_cloud.nix
    ./_core.nix
    ./_developer.nix
    ./_games.nix
    ./_kubernetes.nix
    ./_media.nix
    ./_social.nix
  ];
}
