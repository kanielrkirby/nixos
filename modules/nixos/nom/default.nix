{ pkgs, config, lib, ... }:

with lib;
{
  options.gearshift.nom = {
    enable = mkOption {
      type = types.bool;
      default = true;
    };
  };

  config = mkMerge [
    (mkIf config.gearshift.nom.enable {
      home-manager.users."${config.gearshift.username}" = {
        home.packages = with pkgs; [
          nom
        ];

        xdg.configFile."nom/config.yml".text = ''
        feeds:
        - url: https://nixos.org/blog/feed.xml
        name: NixOS Official Blog
        - url: https://old.reddit.com/r/NixOS/.rss
        name: NixOS Reddit
        - url: https://github.com/nix-community/awesome-nix/commits.atom
        name: NixOS Awesome GitHub
        '';
      };
    })
  ];
}
