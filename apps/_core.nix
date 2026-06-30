{ lib, config, pkgs, ... }: {
  config = lib.mkIf config.apps.core {
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
        pkgs.xz

        # other
        pkgs.autojump
        pkgs.pandoc
        pkgs.nur.repos.rapatao.md2

        # network tools
        pkgs.wget
        pkgs.curl
        pkgs.inetutils
        pkgs.dig
      ];
    };

    homebrew = {
      brews = [
        "mas"
        "coreutils"
      ];
      casks = [
        "iterm2"
        "ghostty"
        "rectangle"
        "caffeine"
        "alfred"
        "mounty"
        "logitech-camera-settings"
        "openlogi"
        "puremac"
      ];
    };
  };
}
