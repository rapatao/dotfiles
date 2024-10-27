{ lib, config, pkgs, ... }:
let cfg = config.install-developer; in {
  options = {
    install-developer.enable = lib.mkEnableOption "Install Development Tools";
  };

  config = lib.mkIf cfg.enable {
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
