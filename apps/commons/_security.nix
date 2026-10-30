{ lib, config, pkgs, ... }:
(import ../group.nix { inherit lib config; } "security").packages ([
  pkgs.openssl
  pkgs.gnupg
  pkgs.transcrypt
  pkgs.sshpass
  pkgs.pinentry-curses
] ++ lib.optional pkgs.stdenv.hostPlatform.isDarwin pkgs.pinentry_mac)
