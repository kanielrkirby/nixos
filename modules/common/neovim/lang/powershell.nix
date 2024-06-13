{ pkgs, ... }:

{
  programs.nixvim = {
    extraConfigLua = ''
    local bundle_path = '${pkgs.fetchFromGitHub {
      owner = "PowerShell";
      repo = "PowerShellEditorServices";
      rev = "v3.20.1";
      sha256 = "sha256-LvurkLCpP1VOG/4j6PLW69rA6SJxCNgk3SQyLVgv7Kg=";
    }}'

    require('lspconfig')['powershell_es'].setup {
        bundle_path = bundle_path,
        on_attach = on_attach
    }
    '';
  };
}
