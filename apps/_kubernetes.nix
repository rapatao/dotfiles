{ lib, config, pkgs, ... }: {
  config = lib.mkIf config.apps.kubernetes {
    environment = {
      systemPackages = [
        pkgs.kubectl
        pkgs.kubernetes-helm
        pkgs.helmfile
        pkgs.kustomize
      ];
    };
  };
}
