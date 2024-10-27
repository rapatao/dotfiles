{ lib, config, pkgs, ... }:
let cfg = config.install-media; in {
  options = {
    install-media.enable = lib.mkEnableOption "Install Media Tools";
  };

  config = lib.mkIf cfg.enable {
    environment = {
      systemPackages = [
        pkgs.ffmpeg
        pkgs.imagemagick
      ];
    };

    homebrew = {
      casks = [
        "vlc"
      ];
    };
  };
}
