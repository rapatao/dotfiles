{ lib, config, pkgs, ... }: {
  config = lib.mkIf config.apps.social {
    environment = {
      systemPackages = [
        # Add social-related CLI tools here
      ];
    };
  };
}
