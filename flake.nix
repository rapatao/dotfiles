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
      configuration = { pkgs, config, lib, apps, ... }: {

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

            # other
            pkgs.autojump

            # certificates
            pkgs.openssl
            pkgs.gnupg
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
            pkgs.yq-go
            pkgs.git
            pkgs.git-crypt
            pkgs.vim
            pkgs.neovim
            pkgs.nixpkgs-fmt
          ]

          ++ (lib.optionals (apps.cloud-manager) [
            pkgs.infisical
            pkgs.flyctl
            pkgs.awscli
          ])

          ++ (lib.optionals (apps.kubernetes) [
            pkgs.kubectl
            pkgs.kubernetes-helm
            pkgs.helmfile
            pkgs.kustomize
          ])

          ++ (lib.optionals (apps.c-lang) [
            pkgs.cmake
          ])

          ++ (lib.optionals (apps.nodejs) [
            pkgs.yarn
          ])

          ++ (lib.optionals (apps.golang) [
            pkgs.go
            pkgs.golangci-lint
          ])

          ++ (lib.optionals (apps.blog) [
            pkgs.hugo
            pkgs.ffmpeg
            pkgs.imagemagick
          ]);
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
            "mounty"
            "xbar"
            "logitech-options"
            "logitech-camera-settings"
          ]

          ++ (lib.optionals (apps.media-player) [
            "vlc"
          ])

          ++ (lib.optionals (apps.social) [
            "discord"
            "slack"
          ])

          ++ (lib.optionals (apps.games) [
            "whisky"
            "heroic"
            "godot"
          ]);
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
        specialArgs = {
          apps = {
            blog = true;
            cloud-manager = true;
            kubernetes = true;
            c-lang = true;
            nodejs = true;
            golang = true;
            games = true;
            social = true;
            media-player = true;
          };
        };
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
