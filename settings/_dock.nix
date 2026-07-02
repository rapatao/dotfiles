{ config, lib, ... }: {
  config = {
    system = {
      defaults = {
        dock = {
          autohide = false;
          tilesize = 32;
          show-recents = false;
          showhidden = true;
          persistent-apps = [
            #"${pkgs.}"
            "/Applications/Google Chrome.app"
            "/Applications/Ghostty.app"
          ]
          ++ (lib.optionals (config.apps.social) [
            "/Applications/Slack.app"
            "/Applications/Discord.app"
          ]);
        };
      };
    };

  };
}
