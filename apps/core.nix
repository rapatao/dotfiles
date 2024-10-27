{ pkgs, ... }: {
  config = {
    environment = {
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
      ];
    };

    homebrew = {
      brews = [
        "mas"
      ];
      casks = [
        "iterm2"
        "rectangle"
        "caffeine"
        "alfred"
        "mounty"
        "xbar"
        "logitech-options"
        "logitech-camera-settings"
        "google-chrome"
      ];
      onActivation = {
        cleanup = "zap";
        autoUpdate = true;
        upgrade = true;
      };
    };
  };
}
