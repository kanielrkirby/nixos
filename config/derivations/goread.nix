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
        hash = "sha256-yPf9/SM4uET/I8FsDU1le9JgxELu0DR9k7mv8PnBwvQ=";
      };
    
      vendorHash = "sha256-/kxEnw8l9S7WNMcPh1x7xqiQ3L61DSn6DCIvJlyrip0=";
    
      meta = with pkgs.lib; {
        description = "RSS reader for the terminal in BubbleTea and Golang.";
        homepage = "https://github.com/TypicalAM/goread";
        license = pkgs.lib.licenses.mit;
        maintainers = with pkgs.lib.maintainers; [ ];
      };
    })
  ];
}
