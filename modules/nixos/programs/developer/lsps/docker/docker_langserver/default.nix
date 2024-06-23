{
  pkgs,
  config,
  lib,
  namespace,
  ...
}: let
  inherit (lib) mkIf;
  inherit (lib.${namespace}) mkBoolOpt;

  cfg = config.${namespace}.programs.developer.lsps.docker.docker_langserver;
in {
  options.${namespace}.programs.developer.lsps.docker.docker_langserver = {
    enable = mkBoolOpt false "Whether or not to enable the docker_langserver.";
  };

  config = mkIf cfg.enable {
    environment.systemPackages = with pkgs; [dockerfile-language-server-nodejs];
  };
}
