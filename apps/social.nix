{ lib, config, pkgs, ... }:
let cfg = config.install-social; in {
  options = {
    install-social.enable = lib.mkEnableOption "Install Social Tools";
  };

  config = lib.mkIf cfg.enable {
    homebrew = {
      casks = [
        "discord"
        "slack"
      ];
    };
  };
}
