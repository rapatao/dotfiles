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
        pkgs.obsidian

        # network tools
        pkgs.wget
        pkgs.curl
        pkgs.inetutils
        pkgs.dig
      ];
    };
  };
}
