{ inputs, pkgs, ... }: {
  # options with the same shape on nix-darwin and NixOS

  imports = [
    ./apps/commons
    ./settings/commons
  ];

  nix = {
    package = pkgs.nix;

    # Necessary for using flakes on this system.
    settings = {
      experimental-features = "nix-command flakes";
    };
  };

  programs.zsh.enable = true;

  nixpkgs = {
    overlays = [ inputs.nur.overlays.default ];
    config = {
      allowUnfree = true;
    };
  };
}
