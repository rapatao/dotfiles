{ lib, config, ... }: {
  config = lib.mkIf config.apps.media {
    homebrew = {
      casks = [
        "vlc"
        "stremio"
      ];
    };
  };
}
