{ lib, config, ... }: {
  config = lib.mkIf config.apps.developer {
    homebrew = {
      taps = [
        "akitaonrails/tap"
      ];
      casks = [
        "jetbrains-toolbox"
        "visual-studio-code"
        "docker-desktop"
      ];
      brews = [
        "rtk"
        "akitaonrails/tap/ai-memory"
      ];
    };
  };
}
