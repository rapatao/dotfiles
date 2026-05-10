{ lib, config, pkgs, ... }: {
  config = lib.mkIf config.apps.security {
    environment = {
      systemPackages = [
        pkgs.openssl
        pkgs.gnupg
        pkgs.transcrypt
        pkgs.sshpass
        pkgs.pinentry-curses
        pkgs.pinentry_mac
      ];
    };
  };
}
