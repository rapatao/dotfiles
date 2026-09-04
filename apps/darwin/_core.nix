{ lib, config, ... }: {
  config = lib.mkIf config.apps.core {
    homebrew = {
      taps = [
        "rapatao/tap"
      ];
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
        "virtual-display"
      ];
    };
  };
}
