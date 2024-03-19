{ username, ... }:

{
  home-manager.users."${username}" = { programs.less = { enable = true; }; };
}
