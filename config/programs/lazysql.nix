{ username, ... }:

let
  lazysql = builtins.buildGoModule {
    src = "${builtins.fetchFromGitHub {
      owner = "jorgerojas26";
      repo = "lazysql";
      rev = "master";
      sha256 = "sha256-9QmZJtCj6k1kWkNw+L9SxZcZw1jQoXu4k5u0JXhSbI=";
    }}/lazysql";
  };
in
{
  home-manager.users."${username}".home.packages = [ lazysql ];
}
