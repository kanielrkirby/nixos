{
  pkgs,
  config,
  lib,
  namespace,
  ...
}: let
  inherit (lib) mkIf;
  inherit (lib.${namespace}) mkBoolOpt;
  inherit (pkgs) fetchFromGitHub;
  inherit (builtins) fromTOML unsafeDiscardStringContext readFile;

  cfg = config.${namespace}.programs.terminal.rice.oh-my-posh;
in {
  options.${namespace}.programs.terminal.rice.oh-my-posh = {
    enable = mkBoolOpt false "Whether or not to enable oh-my-posh.";
  };

  config = mkIf (cfg.enable && config.${namespace}.user.enable) {
    home-manager.users.${config.${namespace}.user.name}.programs.oh-my-posh = {
      enable = true;
      settings = fromTOML
        (unsafeDiscardStringContext 
          (readFile "${fetchFromGitHub {
            owner = "dreamsofautonomy";
            repo = "zen-omp";
            rev = "df8107b3399333ac509e7bd58efbbb3fad00cc4c";
            hash = "sha256-rYaAYC6VJe+2PptQGAiOVhotTGQTpl3pt/PJtUpXdzY=";
          }}/zen.toml"));
    };
  };
}
