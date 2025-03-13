{ lib, config, pkgs, ... }: {
  config = lib.mkIf config.apps.social {
    homebrew = {
      casks = [
        "discord"
        "slack"
      ];
      onActivation = {
        cleanup = "zap";
        autoUpdate = true;
        upgrade = true;
      };
    };
  };
}
