{ config, lib, pkgs, ... }:

with lib;
{
  options.gearshift.ollama.enable = mkEnableOption "Ollama";

  config = mkIf config.gearshift.ollama.enable {
    services.ollama = {
      enable = true;
    };
  };
}
