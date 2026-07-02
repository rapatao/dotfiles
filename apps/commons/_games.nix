{ lib, config, pkgs, ... }: {
  config = lib.mkIf config.apps.games {
    # no portable (cross-platform) packages yet — see apps-darwin/_games.nix
  };
}
