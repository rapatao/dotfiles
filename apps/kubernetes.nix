{ lib, config, pkgs, ... }:
let cfg = config.install-kubernetes; in {
  options = {
    install-kubernetes.enable = lib.mkEnableOption "Install Kubernetes Apps";
  };

  config = lib.mkIf cfg.enable {
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
