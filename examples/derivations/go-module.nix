{ pkgs, ... }:

{
  systemPackages = [
    pkgs.buildGoModule rec {
      pname = "goread";
      version = "1.6.4";
    
      src = pkgs.fetchFromGitHub {
        owner = "TypicalAM";
        repo = "goread";
        rev = "v${version}";
        hash = "sha256-gJw1dRrgM8D3G7v6WIM2+50r4HmTXvx0Xxme2fH9TlQ=";
      };
    
      vendorHash = "sha256-CIBIR+a1oaYH+H1PcC8cD8ncfJczk1IiJ8iYNM+R6aA=";
    
      meta = with pkgs.lib; {
        description = "Simple command-line snippet manager, written in Go";
        homepage = "https://github.com/knqyf263/pet";
        license = pkgs.licenses.mit;
        maintainers = with pkgs.maintainers; [ TypicalAM ];
      };
    }
  ];
}
