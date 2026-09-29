{ config, lib, pkgs, ... }:
let
  dockApps = [
    "/Applications/Google Chrome.app"
    "/Applications/Ghostty.app"
  ]
  ++ (lib.optionals (config.apps.social) [
    "/Applications/Slack.app"
    "/Applications/Discord.app"
  ]);
in
{
  config = {
    system = {
      defaults = {
        dock = {
          autohide = false;
          tilesize = 32;
          show-recents = false;
          showhidden = true;
        };
      };

      # persistent-apps replaces the whole Dock, dropping anything pinned by hand,
      # so the Dock is wiped once on first setup and later runs only append missing entries.
      # Delete ~/.local/state/nix-darwin/dock-initialized to wipe it again.
      # nix-darwin applies system.defaults.dock with `killall Dock`, but the Dock
      # exits 0 on SIGTERM and its LaunchAgent is KeepAlive.SuccessfulExit = false,
      # so launchd treats it as done and never brings it back.
      activationScripts.postActivation.text = ''
        user=${config.system.primaryUser}
        uid=$(id -u -- "$user")
        dockChanged=0
        dockMarker="$(eval echo "~$user")/.local/state/nix-darwin/dock-initialized"
        if [ ! -e "$dockMarker" ]; then
          sudo -u "$user" ${pkgs.dockutil}/bin/dockutil --remove all --no-restart >/dev/null
          sudo -u "$user" mkdir -p "$(dirname "$dockMarker")"
          sudo -u "$user" touch "$dockMarker"
          dockChanged=1
        fi
        for app in ${lib.escapeShellArgs dockApps}; do
          if [ -e "$app" ] && ! sudo -u "$user" ${pkgs.dockutil}/bin/dockutil --find "$app" >/dev/null 2>&1; then
            sudo -u "$user" ${pkgs.dockutil}/bin/dockutil --add "$app" --no-restart >/dev/null && dockChanged=1
          fi
        done
        [ "$dockChanged" = 1 ] && killall Dock && sleep 1 || true
        pgrep -qx Dock || launchctl kickstart "gui/$uid/com.apple.Dock.agent" || true
      '';
    };

  };
}
