{ config, pkgs, ... }: {
  config = {
    fonts.packages = [
      (pkgs.nerdfonts.override { fonts = [ "JetBrainsMono" ]; })
    ];
  };
}
