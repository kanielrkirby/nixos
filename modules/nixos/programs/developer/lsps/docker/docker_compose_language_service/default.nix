{
  pkgs,
  config,
  lib,
  namespace,
  ...
}: let
  inherit (lib) mkIf;
  inherit (lib.${namespace}) mkBoolOpt;

  cfg = config.${namespace}.programs.developer.lsps.docker.docker_compose_language_service;
in {
  options.${namespace}.programs.developer.lsps.docker.docker_compose_language_service = {
    enable = mkBoolOpt false "Whether or not to enable the docker_compose_language_service.";
  };

  config = mkIf cfg.enable {
    environment.systemPackages = with pkgs; [docker-compose-language-service];
  };
}
