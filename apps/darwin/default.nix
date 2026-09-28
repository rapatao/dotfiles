{ ... }: {
  # homebrew (macOS-only) halves of ../commons/_*.nix, gated by the same
  # apps.* options declared in apps/commons/default.nix. Only imported by
  # darwin-common.nix.

  imports = [
    ./_core.nix
    ./_developer.nix
    ./_devops.nix
    ./_games.nix
    ./_media.nix
    ./_social.nix
    ./_web.nix
  ];
}
