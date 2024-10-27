{
  description = "Darwin system flake";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixpkgs-unstable";
    nix-darwin = {
      url = "github:LnL7/nix-darwin";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    nix-homebrew.url = "github:zhaofengli-wip/nix-homebrew";
  };

  outputs = inputs@{ self, nix-darwin, nixpkgs, nix-homebrew }:
    let
      configuration = { pkgs, config, lib, ... }: {

        imports = [
          ./apps
          ./settings
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

        # Auto upgrade nix package and the daemon service.
        services = {
          nix-daemon = {
            enable = true;
          };
        };

        nix = {
          # package = pkgs.nix;

          # Necessary for using flakes on this system.
          settings = {
            experimental-features = "nix-command flakes";
          };
        };

        programs = {
          zsh = {
            # Create /etc/zshrc that loads the nix-darwin environment.
            enable = true; # default shell on catalina
          };
        };

        # The platform the configuration will be used on.
        nixpkgs = {
          hostPlatform = "aarch64-darwin";
          config = {
            allowUnfree = true;
          };
        };
      };
    in
    {
      # Build darwin flake using:
      # $ darwin-rebuild build --flake .#home
      darwinConfigurations."home" = nix-darwin.lib.darwinSystem {
        modules = [
          configuration
          nix-homebrew.darwinModules.nix-homebrew
          {
            nix-homebrew = {
              user = "rapatao";
            };

            apps = {
              blog = true;
              cloud = true;
              developer = true;
              games = true;
              kubernetes = true;
              media = true;
              social = true;
            };
          }
        ];
      };

      # Expose the package set, including overlays, for convenience.
      darwinPackages = self.darwinConfigurations."home".pkgs;
    };
}
