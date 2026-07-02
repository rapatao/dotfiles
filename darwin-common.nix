{ self, ... }: {
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
