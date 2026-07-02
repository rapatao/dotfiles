{ lib, config, pkgs, ... }: {
  config = lib.mkIf config.apps.web {
    # no portable (cross-platform) packages yet — see apps-darwin/_web.nix
  };
}
