{ lib, config, ... }: {
  config = lib.mkIf config.apps.core {
    homebrew = {
      taps = [
        { name = "rapatao/tap"; trusted = true; }
      ];
      brews = [
        "mas"
        "coreutils"
      ];
      casks = [
        "ghostty"
        "rectangle"
        "caffeine"
        "alfred"
        "mounty"
        "openlogi"
        "virtual-display"
      ] ++ lib.optionals config.apps.personal [
        "puremac"
      ];
    };
  };
}
