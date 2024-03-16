{ username, ... }:

{
  home-manager.users."${username}" = {
    programs.eza = {
      enable = true;
      enableAliases = true;
      icons = true;
    };
  };
}
