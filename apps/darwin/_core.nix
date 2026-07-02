{ lib, config, ... }: {
  config = lib.mkIf config.apps.core {
    homebrew = {
      brews = [
        "mas"
        "coreutils"
      ];
      casks = [
        "iterm2"
        "ghostty"
        "rectangle"
        "caffeine"
        "alfred"
        "mounty"
        "logitech-camera-settings"
        "openlogi"
        "puremac"
      ];
    };
  };
}
