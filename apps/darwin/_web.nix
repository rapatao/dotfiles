{ lib, config, ... }: {
  config = lib.mkIf config.apps.web {
    homebrew = {
      casks = [
        "google-chrome"
      ] ++ lib.optionals config.apps.personal [
        "cloudflare-warp"
      ];
    };
  };
}
