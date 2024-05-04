{ pkgs, config, lib, ... }:

with lib;
{
  options.gearshift.shell = {
    scripts = mkOption {
      type = types.str;
      default = "";
    };
  };
}
