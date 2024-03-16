{ username, pkgs, ... }:

{
  home-manager.users."${username}" = {
    programs.alacritty = {
      enable = true;
      settings = {
        import = [
          "${
            pkgs.fetchFromGitHub {
              owner = "alacritty";
              repo = "alacritty-theme";
              rev = "master";
              sha256 = "sha256-+35S6eQkxLBuS/fDKD5bglQDIuz2xeEc5KSaK6k7IjI=";
            }
          }/themes/catppuccin_mocha.toml"
        ];
        window = { opacity = 0.9; };
        font = {
          normal = {
            family = "MonaspiceNe NF";
            style = "Regular";
          };
          italic = {
            family = "MonaspiceRn NF";
            style = "Regular";
          };
        };
      };
    };
  };
}
