{ pkgs, ... }:

{
  environment.systemPackages = [
    (pkgs.buildGoModule rec {
      pname = "goread";
      version = "1.6.4";
    
      src = pkgs.fetchFromGitHub {
        owner = "TypicalAM";
        repo = "goread";
        rev = "v${version}";
        hash = "sha256-m6reRaJNeFhJBUatfPNm66LwTXPdD/gioT8HTv52QOw=";
      };
    
      vendorHash = "sha256-CIBIR+a1oaYH+H1PcC8cD8ncfJczk1IiJ8iYNM+R6aA=";
    
      meta = with pkgs.lib; {
        description = "Simple command-line snippet manager, written in Go";
        homepage = "https://github.com/knqyf263/pet";
        license = pkgs.lib.licenses.mit;
        maintainers = with pkgs.lib.maintainers; [ ];
      };
    })
  ];
}
