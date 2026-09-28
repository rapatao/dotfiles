{ lib, config, ... }: {
  config = lib.mkIf config.apps.security {
    homebrew = {
      casks = [
        "gpg-suite"
      ];
    };
  };
}
