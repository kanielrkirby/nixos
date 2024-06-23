{
  lib,
  namespace,
  ...
}: let
  inherit (lib.${namespace}) systemVersion;
in {
  ${namespace} = {
  };

  system.stateVersion = systemVersion;
}
