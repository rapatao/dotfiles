{ lib, config, pkgs, ... }: {
  config = lib.mkIf config.apps.developer {
    environment = {
      systemPackages = [
        # development
        pkgs.jq
        pkgs.yq-go
        pkgs.git
        pkgs.git-crypt

        # editors
        pkgs.vim
        pkgs.neovim
        pkgs.nixpkgs-fmt

        # c lang
        pkgs.cmake
        pkgs.ninja

        # javascript
        pkgs.nodejs
        pkgs.yarn

        # go lang
        pkgs.go
        pkgs.golangci-lint
        pkgs.delve

        # rust
        pkgs.cargo

        # testing
        pkgs.k6
      ];
    };

    homebrew = {
      casks = [
        "jetbrains-toolbox"
        "visual-studio-code"
      ];
    };
  };
}
