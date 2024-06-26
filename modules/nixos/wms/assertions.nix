{
  config,
  lib,
  namespace,
  ...
}: {
  config = {
    assertions = [
      {
        assertion =
          lib.length (lib.filter (x: x) [
            config.${namespace}.wms.hypr.enable
            config.${namespace}.wms.hyprland.enable
            config.${namespace}.wms.i3.enable
          ])
          <= 1;
        message = "You can only have one Window Manager enabled";
      }
    ];
  };
}
