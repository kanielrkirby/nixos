{
  lib,
  namespace,
  ...
}: let
  inherit (lib.${namespace}) systemVersion username;
in {
  gearshift = {
  };

  system.stateVersion = systemVersion;
}
