{ ... }: {
  # macOS-only System Preferences / PAM settings. Not portable to NixOS.
  # Only imported by darwin-common.nix.

  imports = [
    ./_dock.nix
    ./_security.nix
    ./_system.nix
  ];
}
