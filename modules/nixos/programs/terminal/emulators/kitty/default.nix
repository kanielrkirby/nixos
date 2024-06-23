{
  config,
  lib,
  namespace,
  ...
}: let
  inherit (lib) mkIf;
  inherit (lib.${namespace}) mkBoolOpt;

  cfg = config.${namespace}.programs.terminal.emulators.kitty;
in {
  options.${namespace}.programs.terminal.emulators.kitty = {
    enable = mkBoolOpt false "Whether or not to enable kitty.";
  };

  config = mkIf (cfg.enable && config.${namespace}.user.enable) {
    home-manager.users.${config.${namespace}.user.name}.programs.kitty = {
      enable = true;
      extraConfig = ''
        confirm_os_window_close 0
        background_opacity      0.8
        font_family             MonaspiceNe NF
        italic_font             MonaspiceRn NF
        font_size               12
        enable_audio_bell       no
      '';
    };
  };
}
