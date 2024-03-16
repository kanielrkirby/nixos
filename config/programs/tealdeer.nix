{ username, ... }:

{
  home-manager.users."${username}" = {
    programs.tealdeer.enable = true;
    xdg.configFile."tealdeer/config.toml".text = ''
      [display]
      compact = false
      use_pager = false

      [style.description]
      foreground = { rgb = { r = 205, g = 214, b = 244 } }

      [style.command_name]
      foreground = { rgb = { r = 180, g = 160, b = 220 } }

      [style.example_code]
      foreground = { rgb = { r = 205, g = 214, b = 244 } }

      [style.example_text]
      foreground = { rgb = { r = 205, g = 214, b = 244 } }

      [style.example_variable]
      foreground = { rgb = { r = 205, g = 214, b = 244 } }

      [updates]
      auto_update = true
      auto_update_interval_hours = 24
    '';
  };
}
