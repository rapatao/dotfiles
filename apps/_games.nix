{ lib, config, pkgs, ... }: {
  config = lib.mkIf config.apps.games {
    homebrew = {
      casks = [
        "whisky"
        "heroic"
        "godot"
      ];
    };
  };
}
