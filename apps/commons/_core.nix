{ lib, config, pkgs, ... }:
(import ../group.nix { inherit lib config; } "core").packages [
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
  pkgs.imagemagick
  pkgs.nur.repos.rapatao.md2
  pkgs.obsidian
  pkgs.uhubctl

  # network tools
  pkgs.wget
  pkgs.curl
  pkgs.inetutils
  pkgs.dig
]
