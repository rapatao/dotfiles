{ lib, config, ... }: {
  config = lib.mkIf config.apps.web {
    homebrew = {
      casks = [
        "google-chrome"
        "cloudflare-warp"
      ];
    };
  };
}
