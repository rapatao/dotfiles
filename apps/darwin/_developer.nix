{ lib, config, ... }: {
  config = lib.mkIf config.apps.developer {
    homebrew = {
      casks = [
        "jetbrains-toolbox"
        "visual-studio-code"
        "docker-desktop"
      ];
      brews = [
        "rtk"
      ];
    };
  };
}
