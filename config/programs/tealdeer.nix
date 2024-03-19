{ username, ... }:

{
  home-manager.users."${username}" = {
    programs.tealdeer.enable = true;
  };
}
