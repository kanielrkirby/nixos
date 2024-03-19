{ username, ... }:

{
  home-manager.users."${username}" = { programs.thunar = { enable = true; }; };
}

