{ lib, config, pkgs, ... }:
let cfg = config.install-games; in {
  options = {
    install-games.enable = lib.mkEnableOption "Install Gaming Tools";
  };

  config = lib.mkIf cfg.enable {
    homebrew = {
      casks = [
        "whisky"
        "heroic"
        "godot"
      ];
    };
  };
}
