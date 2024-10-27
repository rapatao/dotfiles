{ lib, config, pkgs, ... }:
let cfg = config.install-cloud; in {
  options = {
    install-cloud.enable = lib.mkEnableOption "Install Cloud Manager Apps";
  };

  config = lib.mkIf cfg.enable {
    environment = {
      systemPackages = [
        pkgs.infisical
        pkgs.flyctl
        pkgs.awscli
      ];
    };
  };
}
