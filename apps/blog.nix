{ lib, config, pkgs, ... }:
let cfg = config.install-blog; in {
  options = {
    install-blog.enable = lib.mkEnableOption "Install Blog Development Tools";
  };

  config = lib.mkIf cfg.enable {
    environment = {
      systemPackages = [
        pkgs.hugo
        pkgs.imagemagick
      ];
    };
  };
}
