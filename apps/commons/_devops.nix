{ lib, config, pkgs, ... }:
(import ../group.nix { inherit lib config; } "devops").packages [
  # cloud tools
  pkgs.awscli2
  pkgs.aws-vault
  pkgs.flyctl

  # kubernetes
  pkgs.kubectl
  pkgs.kubernetes-helm
  pkgs.helmfile
  pkgs.kustomize

  # provisioning
  pkgs.ansible
  pkgs.colmena
]
