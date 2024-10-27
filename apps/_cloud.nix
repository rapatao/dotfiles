{ lib, config, pkgs, ... }: {
  config = lib.mkIf config.apps.cloud {
    environment = {
      systemPackages = [
        pkgs.infisical
        pkgs.flyctl
        pkgs.awscli
      ];
    };
  };
}
