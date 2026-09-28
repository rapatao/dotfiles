{
  description = "Darwin system flake";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixpkgs-unstable";
    nix-darwin = {
      url = "github:LnL7/nix-darwin";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    nix-homebrew.url = "github:zhaofengli-wip/nix-homebrew";
    nur = {
      url = "github:nix-community/NUR";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = inputs@{ self, nix-darwin, nixpkgs, nix-homebrew, nur }:
    let
      mkDarwinConfig = { hostUser, hostUid ? null, determinate ? false, apps }:
        nix-darwin.lib.darwinSystem {
          specialArgs = { inherit inputs self; };
          modules = [
            ./common.nix
            ./darwin-common.nix
            nix-homebrew.darwinModules.nix-homebrew
            ({ pkgs, lib, ... }: {
              system = {
                primaryUser = hostUser;
              };

              # Determinate runs its own nix daemon; nix-darwin aborts activation if it also manages nix.
              nix.enable = !determinate;

              nix-homebrew = {
                user = hostUser;
              };

              # keep /etc/shells and this account's UserShell in sync with
              # whichever zsh nix currently provides, so the login shell and
              # the zsh that compiles ~/.zcompdump.zwc are always the same
              # binary/version.
              environment.shells = [ pkgs.zsh ];
              users = lib.mkIf (hostUid != null) {
                knownUsers = [ hostUser ];
                users.${hostUser} = {
                  uid = hostUid;
                  shell = pkgs.zsh;
                };
              };

              inherit apps;
            })
          ];
        };
    in
    {
      # Build darwin flake using:
      # $ darwin-rebuild build --flake .#home
      darwinConfigurations."home" = mkDarwinConfig {
        hostUser = "rapatao";
        hostUid = 501;
        apps = {
          blog = true;
          core = true;
          developer = true;
          devops = true;
          games = true;
          media = true;
          personal = true;
          security = true;
          social = true;
          web = true;
        };
      };

      # $ darwin-rebuild build --flake .#work-m5-pro
      # No hostUid: user accounts are left unmanaged.
      darwinConfigurations."work-m5-pro" = mkDarwinConfig {
        hostUser = "luiz.rapatao";
        determinate = true;
        apps = {
          core = true;
          developer = true;
          devops = true;
          security = true;
          web = true;
        };
      };

      # Expose the package set, including overlays, for convenience.
      # darwinPackages = self.darwinConfigurations."home".pkgs;
    };
}
