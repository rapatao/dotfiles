{ lib, config, pkgs, ... }: {
  config = lib.mkIf config.apps.developer {
    environment = {
      systemPackages = [
        # development
        pkgs.jq
        pkgs.yq-go
        pkgs.git
        pkgs.git-crypt

        # lsp
        pkgs.lua-language-server
        pkgs.ast-grep

        # formatters
        pkgs.stylua

        # editors
        pkgs.vim
        pkgs.neovim
        pkgs.nixpkgs-fmt

        # c lang
        pkgs.cmake
        pkgs.ninja

        # javascript
        pkgs.yarn

        # go lang
        pkgs.go
        pkgs.golangci-lint
        pkgs.delve
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
