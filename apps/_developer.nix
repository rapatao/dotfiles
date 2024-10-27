{ lib, config, pkgs, ... }: {
  config = lib.mkIf config.apps.developer {
    environment = {
      systemPackages = [
        # development
        pkgs.jq
        pkgs.yq-go
        pkgs.git
        pkgs.git-crypt
        pkgs.vim

        # ide's
        pkgs.neovim
        pkgs.nixpkgs-fmt

        # c lang
        pkgs.cmake
        # javascript
        pkgs.yarn
        # go lang
        pkgs.go
        pkgs.golangci-lint
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
