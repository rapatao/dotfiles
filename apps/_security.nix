{ lib, config, pkgs, ... }: {
  options.apps.security = lib.mkEnableOption "Install security tools";

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
