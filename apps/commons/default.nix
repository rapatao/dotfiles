{ lib, config, ... }:
let
  groups = {
    blog = "blog development tools";
    core = "core system tools";
    developer = "development tools";
    devops = "devops tools";
    games = "gaming tools";
    media = "media tools";
    security = "security tools";
    social = "social media tools";
    web = "web tools";
  };

  mkGroup = name: description: lib.mkOption {
    default = { };
    type = with lib.types; coercedTo bool (enable: { inherit enable; }) (submodule {
      options = {
        enable = lib.mkEnableOption description;
        exclude = lib.mkOption {
          type = listOf str;
          default = [ ];
          description = "Apps of this group not installed on this machine: nix package pnames (lib.getName) or brew/cask names.";
        };
        declared = lib.mkOption {
          type = listOf str;
          default = [ ];
          internal = true;
        };
      };
    });
  };
in
{
  options.apps = lib.mapAttrs mkGroup groups;

  config.assertions = lib.concatLists (lib.mapAttrsToList
    (name: _:
      let
        inherit (config.apps.${name}) declared exclude;
        unknown = lib.subtractLists declared exclude;
        duplicated = lib.unique (lib.filter (app: lib.count (other: other == app) declared > 1) declared);
      in
      [
        {
          assertion = unknown == [ ];
          message = "apps.${name}.exclude: unknown app(s): ${lib.concatStringsSep ", " unknown}. "
            + "Known: ${lib.concatStringsSep ", " (lib.sort lib.lessThan declared)}";
        }
        {
          assertion = duplicated == [ ];
          message = "apps.${name}: app(s) declared more than once: ${lib.concatStringsSep ", " duplicated}";
        }
      ])
    groups);

  imports = [
    ./_blog.nix
    ./_core.nix
    ./_developer.nix
    ./_devops.nix
    ./_media.nix
    ./_security.nix
  ];
}
