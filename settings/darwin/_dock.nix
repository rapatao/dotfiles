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

      # nix-darwin applies system.defaults.dock with `killall Dock`, but the Dock
      # exits 0 on SIGTERM and its LaunchAgent is KeepAlive.SuccessfulExit = false,
      # so launchd treats it as done and never brings it back.
      activationScripts.postActivation.text = ''
        uid=$(id -u -- ${config.system.primaryUser})
        pgrep -qx Dock || launchctl kickstart "gui/$uid/com.apple.Dock.agent" || true
      '';
    };

  };
}
