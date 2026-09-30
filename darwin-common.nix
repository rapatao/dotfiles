{ self, config, lib, pkgs, ... }:
let
  user = config.system.primaryUser;
in
{
  # macOS-only: nix-darwin/homebrew modules, macOS System Preferences,
  # hardcoded platform. Not portable to NixOS.

  imports = [
    ./apps/darwin
    ./settings/darwin
  ];

  nix-homebrew = {
    enable = true;
    enableRosetta = true;
    autoMigrate = true;
  };

  homebrew = {
    enable = true;
    onActivation = {
      cleanup = "zap";
      autoUpdate = true;
      upgrade = true;
    };
  };

  # brew replaces app bundles in place, which breaks apps still running from
  # the old bundle, so outdated running apps are quit before `brew bundle` and
  # reopened after. Order 750 sits between nix-homebrew's tap setup and bundle.
  # Apps in the activation's own process tree (the terminal running the
  # rebuild) are never quit, since that would kill the activation.
  system.activationScripts.homebrew.text = lib.mkMerge [
    (lib.mkOrder 750 ''
      brewUid=$(id -u -- ${user})
      asBrewUser() { launchctl asuser "$brewUid" sudo --user=${user} --set-home "$@"; }
      relaunchApps=()
      activationAncestors=" "
      ancestorPid=$$
      while [ "$ancestorPid" -gt 1 ]; do
        activationAncestors+="$ancestorPid "
        ancestorPid=$(ps -o ppid= -p "$ancestorPid" | tr -d ' ')
      done
      appPids() { pgrep -a -f "^$1/Contents/MacOS/" || true; }
      outdatedCasks=$(asBrewUser /opt/homebrew/bin/brew outdated --cask --quiet || true)
      if [ -n "$outdatedCasks" ]; then
        # shellcheck disable=SC2086
        while IFS= read -r app; do
          appPath="/Applications/$app"
          pids=$(appPids "$appPath")
          [ -n "$pids" ] || continue
          inTree=0
          for pid in $pids; do
            [[ "$activationAncestors" == *" $pid "* ]] && inTree=1
          done
          if [ "$inTree" = 1 ]; then
            echo >&2 "not quitting $app: the rebuild is running inside it, reopen it afterwards"
            continue
          fi
          bundleId=$(defaults read "$appPath/Contents/Info" CFBundleIdentifier 2>/dev/null) || continue
          echo >&2 "quitting $app for upgrade..."
          asBrewUser osascript -e "quit app id \"$bundleId\"" >/dev/null 2>&1 || true
          for _ in $(seq 30); do
            [ -n "$(appPids "$appPath")" ] || break
            sleep 1
          done
          [ -n "$(appPids "$appPath")" ] && echo >&2 "warning: $app did not quit, upgrading anyway"
          relaunchApps+=("$appPath")
        done < <(asBrewUser /opt/homebrew/bin/brew info --cask --json=v2 $outdatedCasks \
          | ${pkgs.jq}/bin/jq -r '.casks[].artifacts[] | .app? // empty | .[] | strings')
      fi
    '')
    (lib.mkAfter ''
      for appPath in "''${relaunchApps[@]}"; do
        echo >&2 "reopening $(basename "$appPath")..."
        asBrewUser open -g "$appPath" || true
      done
    '')
  ];

  system = {
    # Set Git commit hash for darwin-version.
    configurationRevision = self.rev or self.dirtyRev or null;

    # Used for backwards compatibility, please read the changelog before changing.
    # $ darwin-rebuild changelog
    stateVersion = 5;
  };

  # The platform the configuration will be used on.
  nixpkgs.hostPlatform = "aarch64-darwin";
}
