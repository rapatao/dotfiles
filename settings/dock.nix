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
            "/Applications/iTerm.app"
          ]
          ++ (lib.optionals (config.install-social.enable) [
            "/Applications/Slack.app"
            "/Applications/Discord.app"
          ]);
        };
      };
    };

  };
}
