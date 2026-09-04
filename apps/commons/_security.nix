{ lib, config, pkgs, ... }: {
  config = lib.mkIf config.apps.security {
    environment = {
      systemPackages = [
        pkgs.openssl
        pkgs.gnupg
        pkgs.transcrypt
        pkgs.sshpass
        pkgs.pinentry-curses
      ] ++ lib.optional pkgs.stdenv.hostPlatform.isDarwin pkgs.pinentry_mac;
    };
  };
}
