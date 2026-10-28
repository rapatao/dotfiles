{ lib, config, ... }: {
  config = lib.mkIf config.apps.developer {
    homebrew = {
      taps = lib.optionals config.apps.personal [
        "akitaonrails/tap"
      ];
      casks = [
        "jetbrains-toolbox"
        "visual-studio-code"
        "docker-desktop"
      ];
      brews = [
        "rtk"
      ] ++ lib.optionals config.apps.personal [
        "akitaonrails/tap/ai-memory"
      ];
    };
  };
}
