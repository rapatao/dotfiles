{ lib, config, ... }: {
  options = {
    apps.blog = lib.mkEnableOption "Install blog development tools";
    apps.core = lib.mkEnableOption "Install core system tools";
    apps.developer = lib.mkEnableOption "Install development tools";
    apps.devops = lib.mkEnableOption "Install devops tools";
    apps.games = lib.mkEnableOption "Install gaming tools";
    apps.media = lib.mkEnableOption "Install media tools";
    apps.security = lib.mkEnableOption "Install security tools";
    apps.social = lib.mkEnableOption "Install social media tools";
    apps.web = lib.mkEnableOption "Install web tools";
  };

  imports = [
    ./_blog.nix
    ./_core.nix
    ./_developer.nix
    ./_devops.nix
    ./_games.nix
    ./_media.nix
    ./_security.nix
    ./_social.nix
    ./_web.nix
  ];
}
