{ lib, config, pkgs, ... }: {
  options.apps.web = lib.mkEnableOption "Install web tools";

  config = lib.mkIf config.apps.web {
    homebrew = {
      casks = [
        "google-chrome"
        "cloudflare-warp"
      ];
    };
  };
}
