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
      mkDarwinConfig = { hostUser, hostUid, apps }:
        nix-darwin.lib.darwinSystem {
          specialArgs = { inherit inputs self; };
          modules = [
            ./common.nix
            ./darwin-common.nix
            nix-homebrew.darwinModules.nix-homebrew
            ({ pkgs, ... }: {
              system = {
                primaryUser = hostUser;
              };

              nix-homebrew = {
                user = hostUser;
              };

              # keep /etc/shells and this account's UserShell in sync with
              # whichever zsh nix currently provides, so the login shell and
              # the zsh that compiles ~/.zcompdump.zwc are always the same
              # binary/version.
              environment.shells = [ pkgs.zsh ];
              users.knownUsers = [ hostUser ];
              users.users.${hostUser} = {
                uid = hostUid;
                shell = pkgs.zsh;
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
          security = true;
          social = true;
          web = true;
        };
      };

      # Expose the package set, including overlays, for convenience.
      # darwinPackages = self.darwinConfigurations."home".pkgs;
    };
}
