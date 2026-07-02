{ lib, config, ... }: {
  config = lib.mkIf config.apps.devops {
    homebrew = {
      taps = [
        "infisical/get-cli"
      ];

      brews = [
        "infisical"
      ];
    };
  };
}
