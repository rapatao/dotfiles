{ lib, config, ... }: {
  config = lib.mkIf config.apps.social {
    homebrew = {
      casks = [
        "discord"
        "slack"
      ];
    };
  };
}
