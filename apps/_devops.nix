{ lib, config, pkgs, ... }: {
  config = lib.mkIf config.apps.devops {
    environment = {
      systemPackages = [
        # cloud tools
        pkgs.flyctl
        pkgs.awscli

        # kubernetes
        pkgs.kubectl
        pkgs.kubernetes-helm
        pkgs.helmfile
        pkgs.kustomize

        # others
        pkgs.ansible
      ];
    };

    homebrew = {
        taps = [
          "infisical/get-cli"
        ];

        brews = [
          "infisical"
        ];
      };
  };
}
