{ lib, config, pkgs, ... }: {
  config = lib.mkIf config.apps.web {
    homebrew = {
      casks = [
        "google-chrome"
        "cloudflare-warp"
      ];
    };
  };
}
