{ lib, config, pkgs, ... }: {
  config = lib.mkIf config.apps.devops {
    environment = {
      systemPackages = [
        # cloud tools
        pkgs.awscli
        pkgs.aws-vault

        # kubernetes
        pkgs.kubectl
        pkgs.kubernetes-helm
        pkgs.helmfile
        pkgs.kustomize
      ] ++ lib.optionals config.apps.personal [
        pkgs.flyctl
        pkgs.ansible
        pkgs.colmena
      ];
    };
  };
}
