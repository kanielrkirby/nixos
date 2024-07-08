{
  inputs,
  config,
  lib,
  namespace,
  ...
}: let
  # inherit (inputs) nixvim;
  inherit (lib) mkIf;
  inherit (lib.${namespace}) mkBoolOpt enabled;

  cfg = config.${namespace}.programs.editors.neovim;
in {
  options.${namespace}.programs.editors.neovim = {
    enable = mkBoolOpt false "Whether or not to enable neovim.";
  };

  imports = [
    # nixvim.nixosModules.nixvim
    # ./options.nix
    # ./autocmd.nix
    # ./keymaps.nix
  ];

  config = mkIf cfg.enable {
    # programs.nixvim = enabled;
  };
}
