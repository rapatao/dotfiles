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
          ./apps/blog.nix
          ./apps/cloud.nix
          ./apps/core.nix
          ./apps/developer.nix
          ./apps/games.nix
          ./apps/kubernetes.nix
          ./apps/media.nix
          ./apps/social.nix
          ./settings/dock.nix
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

        fonts.packages = [
          (pkgs.nerdfonts.override { fonts = [ "JetBrainsMono" ]; })
        ];

        security = {
          pam = {
            enableSudoTouchIdAuth = true;
          };
        };
        system = {
          defaults = {
            finder = {
              FXPreferredViewStyle = "clmv";
            };

            NSGlobalDomain = {
              AppleICUForce24HourTime = true;
              AppleInterfaceStyle = "Dark";
              KeyRepeat = 2;
            };
          };

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
          {
            install-blog.enable = true;
            install-cloud.enable = true;
            install-developer.enable = true;
            install-games.enable = true;
            install-kubernetes.enable = true;
            install-media.enable = true;
            install-social.enable = true;
          }
          configuration
          nix-homebrew.darwinModules.nix-homebrew
          {
            nix-homebrew = {
              user = "rapatao";
            };
          }
        ];
      };

      # Expose the package set, including overlays, for convenience.
      darwinPackages = self.darwinConfigurations."home".pkgs;
    };
}
