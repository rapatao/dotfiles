{ lib, config, pkgs, ... }: {
  config = lib.mkIf config.apps.social {
    homebrew = {
      casks = [
        "discord"
        "slack"
      ];
    };
  };
}
