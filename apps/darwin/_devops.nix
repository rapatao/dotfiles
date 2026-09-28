{ lib, config, ... }: {
  config = lib.mkIf (config.apps.devops && config.apps.personal) {
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
