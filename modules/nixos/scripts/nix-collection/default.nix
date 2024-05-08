{ config, lib, ... }:

{
  options.gearshift = {
    scripts.nix-collection.enable = lib.mkOption {
      type = lib.types.bool;
      default = false;
    };
  };

  config = lib.mkMerge [
    (lib.mkIf config.gearshift.scripts.nix-collection.enable {
      gearshift.scripts = {
        ns.enable = true;
        nd.enable = true;
        up.enable = true;
        bp.enable = true;
      };
    })
  ];
}
