{pkgs, ...}: {
  programs.nixvim = {
    extraPlugins = [
      {
        plugin = pkgs.vimUtils.buildVimPlugin {
          name = "powershell.nvim";
          src = pkgs.fetchFromGitHub {
            owner = "TheLeoP";
            repo = "powershell.nvim";
            rev = "20025222cac6b5cc2181ca315bcf98d6f01c3461";
            sha256 = "sha256-RxB05wV/Cqmls306CdS1/P+bvtaE90sPa9lciJJSCb4=";
          };
        };
      }
    ];

    extraConfigLua = ''
      local bundle_path = '${pkgs.callPackage ../../../derivations/powershell-editor-services.nix}'

      require('powershell').setup({
        bundle_path = bundle_path,
      })
    '';
  };
}
