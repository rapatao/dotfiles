{ lib, config }: name:
let
  group = config.apps.${name};
  keep = nameOf: builtins.filter (app: !(builtins.elem (nameOf app) group.exclude));
  tapInUse = apps: tap:
    let
      tapApps = builtins.filter (lib.hasPrefix "${tap.name or tap}/") apps;
    in
    tapApps == [ ] || keep baseNameOf tapApps != [ ];
in
{
  packages = list: {
    apps.${name}.declared = map lib.getName list;
    environment.systemPackages = lib.mkIf group.enable (keep lib.getName list);
  };

  homebrew = { taps ? [ ], brews ? [ ], casks ? [ ] }: {
    apps.${name}.declared = map baseNameOf (brews ++ casks);
    homebrew = lib.mkIf group.enable {
      taps = builtins.filter (tapInUse (brews ++ casks)) taps;
      brews = keep baseNameOf brews;
      casks = keep baseNameOf casks;
    };
  };
}
