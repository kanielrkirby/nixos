{ config, username, pkgs, ... }:

{
  home-manager.users."${username}".home.packages = with pkgs; [ mods ];

  home-manager.users."${username}".home = {
    programs.zsh.extraConfig = ''
      alias mods='OPENAI_API_KEY=$(cat "${
        config.sops.secrets."openai.com/sk".path
      }") mods'
    '';
  };
}
