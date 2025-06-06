{ lib, config, pkgs, ... }: {
  config = lib.mkIf config.apps.media {
    environment = {
      systemPackages = [
        pkgs.ffmpeg
        pkgs.imagemagick
      ];
    };

    homebrew = {
      casks = [
        "vlc"
        "stremio"
      ];
      onActivation = {
        cleanup = "zap";
        autoUpdate = true;
        upgrade = true;
      };
    };
  };
}
