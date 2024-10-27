{ lib, config, pkgs, ... }: {
  config = lib.mkIf config.apps.blog {
    environment = {
      systemPackages = [
        pkgs.hugo
        pkgs.imagemagick
      ];
    };
  };
}
