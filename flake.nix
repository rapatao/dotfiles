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
      configuration = { pkgs, config, ... }: {

        environment = {
          # List packages installed in system profile. To search by name, run:
          # $ nix-env -qaP | grep wget
          systemPackages = [
            # dotfiles
            pkgs.yadm
            pkgs.mkalias

            # core tools
            pkgs.coreutils
            pkgs.moreutils
            pkgs.findutils
            pkgs.gnused
            pkgs.unixtools.watch
            pkgs.gnutar

            # to evaluate later
            pkgs.autojump
            pkgs.ffmpeg
            pkgs.imagemagick

            # certificates and secrets
            pkgs.openssl
            pkgs.gnupg
            pkgs.infisical
            pkgs.transcrypt
            pkgs.sshpass
            pkgs.pinentry-curses
            pkgs.pinentry_mac

            # network tools
            pkgs.wget
            pkgs.curl
            pkgs.inetutils
            pkgs.dig

            # development
            pkgs.jq
            pkgs.yq
            pkgs.git
            pkgs.git-crypt
            pkgs.vim
            pkgs.neovim
            pkgs.hugo
            pkgs.nixpkgs-fmt

            # c lang
            pkgs.cmake

            # golang
            pkgs.go
            pkgs.golangci-lint

            # nodejs
            pkgs.yarn

            # cloud managers
            pkgs.flyctl
            pkgs.awscli

            # kubernetes
            pkgs.helmfile
            pkgs.kustomize
          ];
        };

        homebrew = {
          enable = true;
          brews = [
            "mas"
          ];
          casks = [
            "iterm2"
            "rectangle"
            "visual-studio-code"
            "jetbrains-toolbox"
            "caffeine"
            "alfred"
            "heroic"
            "mounty"
            "whisky"
            "discord"
            "slack"
            "xbar"
            "godot"
            "logitech-options"
            "logitech-camera-settings"
            "vlc"
          ];
          masApps = {
            # "Yoink" = 457622435;
          };
          onActivation = {
            cleanup = "zap";
            autoUpdate = true;
            upgrade = true;
          };
        };

        fonts.packages = [
          (pkgs.nerdfonts.override { fonts = [ "JetBrainsMono" ]; })
        ];

        system = {
          defaults = {
            dock = {
              autohide = false;
              tilesize = 32;
              show-recents = false;
              showhidden = true;
              persistent-apps = [
                #"${pkgs.}"
                "/applications/iTerm.app"
                "/Applications/Slack.app"
              ];
            };

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
          configuration
          nix-homebrew.darwinModules.nix-homebrew
          {
            nix-homebrew = {
              enable = true;
              enableRosetta = true;
              user = "rapatao";
              autoMigrate = true;
            };
          }
        ];
      };

      # Expose the package set, including overlays, for convenience.
      darwinPackages = self.darwinConfigurations."home".pkgs;
    };
}
