{
  lib,
  namespace,
  ...
}: let
  inherit (lib.${namespace}) homeVersion;
in {
  gearshift = {
  };

  home.stateVersion = homeVersion;
}
