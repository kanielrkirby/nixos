{ config, lib, ... }:

{
  options.gearshift.alacritty = {
    enable = lib.mkEnableOption "Neovim configuration";
  };

  config = lib.mkIf config.gearshift.alacritty.enable {
    home-manager.users."${config.gearshift.username}" = {
      programs.kitty = {
        enable = true;
        theme = "Catppuccin-Mocha";
        extraConfig = ''
          background_opacity 0.7
          font_family        MonaspiceNe NF
          italic_font        MonaspiceRn NF
          font_size          12
          enable_audio_bell  no
        '';
      };
    };
  };
}
